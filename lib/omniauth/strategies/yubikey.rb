require "omniauth/strategy"

module OmniAuth
  module Strategies
    class Yubikey

      include OmniAuth::Strategy

      attr_accessor :options, :api_id, :api_key

      attr_reader :otp_id

      def initialize(app, api_id = nil, api_key = nil, options = {}, &block)
        self.api_id = api_id
        self.api_key = api_key

        super(app, :yubikey, options, &block)
      end

      def request_phase
        if env["REQUEST_METHOD"] == "GET"
          get_credentials
        else
          perform
        end
      end

      private

        def title
          name.to_s.split("_").map{ |s| s.capitalize }.join(" ")
        end

        def get_credentials
          OmniAuth::Form.build(:title => title) do
            password_field "One-time password", "otp"
          end.to_response
        end

        def otp
          request["otp"]
        end

        def api_url
          options[:api_url] if options
        end

        def perform
          verifier = OmniAuth::Yubikey::Verifier.new(api_id, api_key, api_url)
          result = verifier.verify!(otp)

          @otp_id = result.id

          @env["omniauth.auth"] = auth_hash
          @env["omniauth.yubikey"] = result
          @env["REQUEST_METHOD"] = "GET"
          @env["PATH_INFO"] = "#{OmniAuth.config.path_prefix}/#{name.to_s}/callback"

          call_app!
        rescue OmniAuth::Yubikey::OtpError => e
          fail!(:invalid_credentials, e)
        end

        def callback_phase
          fail!(:invalid_credentials)
        end

        def auth_hash
          OmniAuth::Utils.deep_merge(
            super, {
              "uid" => otp_id,
              "user_info" => {
                "name" => otp_id,
              },
            }
          )
        end

    end
  end
end

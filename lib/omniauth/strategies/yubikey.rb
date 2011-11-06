require "omniauth"

module OmniAuth
  module Strategies
    class Yubikey

      include OmniAuth::Strategy

      args [:api_id, :api_key]

      option :api_id, nil
      option :api_key, nil
      option :api_url, "https://api.yubico.com/wsapi/"

      attr_accessor :otp_id

      def request_phase
        if env["REQUEST_METHOD"] == "GET"
          get_credentials
        else
          perform
        end
      end

      private

        def get_credentials
          OmniAuth::Form.build(:title => "Yubikey") do
            password_field "One-time password", "otp"
          end.to_response
        end

        def otp
          request["otp"]
        end

        def perform
          verifier = OmniAuth::Yubikey::Verifier.new(options.api_id, options.api_key, options.api_url)
          result = verifier.verify!(otp)

          self.otp_id = result.id

          env["omniauth.auth"] = auth_hash
          env["omniauth.yubikey"] = result
          env["REQUEST_METHOD"] = "GET"
          env["PATH_INFO"] = "#{OmniAuth.config.path_prefix}/#{name.to_s}/callback"

          call_app!
        rescue OmniAuth::Yubikey::OtpError => e
          fail!(:invalid_credentials, e)
        end

        def callback_phase
          fail!(:invalid_credentials)
        end

        uid do
          otp_id
        end

    end
  end
end

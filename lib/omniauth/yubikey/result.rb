require "time"

module OmniAuth
  module Yubikey
    class Result

      attr_reader :otp, :id, :hash, :timestamp, :status, :info

      def initialize(otp, response)
        @otp       = otp
        @id        = otp[0, otp.length-32] if otp.length > 32

        response.gsub!("\r\n", "\n")

        hashes     = response.scan(/^h=([\w_\=\/\+]+)$/)[0]
        statuses   = response.scan(/^status=([a-zA-Z0-9_]+)$/)[0]
        timestamps = response.scan(/^t=(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z(\d{4})$/)[0]

        @hash      = hashes[0] if hashes && hashes[0]
        @status    = statuses[0] if statuses && statuses[0]

        if timestamps
          parts = timestamps.map(&:to_i)
          @timestamp = Time.utc(*parts)
        end
      end

      def valid?
        status == "OK"
      end

    end
  end
end
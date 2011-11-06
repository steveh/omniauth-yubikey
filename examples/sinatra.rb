require "rubygems"
require "sinatra"
require "omniauth-yubikey"

use Rack::Session::Cookie

use OmniAuth::Strategies::Yubikey, "XXXX", "XXXXXXXXXXXXXXXXXXXXXXXXX"

enable :sessions

get "/" do
  <<-HTML
  <form action="/auth/yubikey" method="post">
    <input type="text" name="otp" />
    <input type="submit" value="Sign in with Yubikey" />
  </form>
  HTML
end

get "/auth/:name/callback" do
  auth = request.env["omniauth.auth"]

  auth.inspect
end

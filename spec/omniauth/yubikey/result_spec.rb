require "spec_helper"

describe OmniAuth::Yubikey::Result do

  let(:otp)      { "ccccccbcifnhfkunerrbtefthtnidhdjfdctblnfihnh" }
  let(:response) { "h=71poL6Z/yjDBF6twhigu777F+7M=\r\nt=2011-09-28T22:05:58Z0964\r\nstatus=OK\r\n\r\n" }

  before(:all) do
    @result = OmniAuth::Yubikey::Result.new(otp, response)
  end

  it "should return the OTP" do
    @result.otp.should == "ccccccbcifnhfkunerrbtefthtnidhdjfdctblnfihnh"
  end

  it "should extract the Yubikey ID from the OTP" do
    @result.id.should == "ccccccbcifnh"
  end

  it "should extract the Yubikey hash from the response" do
    @result.hash.should == "71poL6Z/yjDBF6twhigu777F+7M="
  end

  it "should extract the Yubikey timestamp from the response" do
    @result.timestamp.utc.should == Time.utc(2011, 9, 28, 22, 5, 58, 964)
  end

  it "should extract the Yubikey status from the response" do
    @result.status.should == "OK"
  end

end

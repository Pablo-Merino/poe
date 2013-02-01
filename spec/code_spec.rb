require "spec_helper"

describe Code do
  it "has a VERSION" do
    Code::VERSION.should =~ /^[\.\da-z]+$/
  end
end

require 'spec_helper'

describe Foursquare, "::ERRORS" do
	it 'should have a message for a required parameter missing' do
		Foursquare::ERRORS.should have_key('param_error')
	end

	it 'should have a message for invalid authorization' do
		Foursquare::ERRORS.should have_key('invalid_auth')
	end

	it 'should have a message for a user not being authorized' do
		Foursquare::ERRORS.should have_key('not_authorized')
	end

	it 'should have a message for exceeding a rate limit' do
		Foursquare::ERRORS.should have_key('rate_limit_exceeded')
	end

	it 'should have a message for an invalid authorization error' do
		Foursquare::ERRORS.should have_key('deprecated')
	end

	it 'should have a message for a server error' do
		Foursquare::ERRORS.should have_key('server_error')
	end

	it 'should have a message for an unknown error' do
		Foursquare::ERRORS.should have_key('other')
	end

end

describe Foursquare, "::verbose*" do
  it "should describe and set the verbose setting" do
    Foursquare::verbose?.should be_nil
    Foursquare::verbose=true
    Foursquare::verbose?.should be_true
  end
end

describe Foursquare, "::log" do
	it 'should not output anything if verbose is not defined' do
    Foursquare::verbose=false
    Kernel.should_not_receive(:puts)
    Foursquare::log("Log Message")
	end

	it 'should output a line if verbose is set to true' do
    Foursquare::verbose=true
    Foursquare::log("Log Message")
	end
end
require './lib/twilio-rb'
require "test/unit"
%w<webmock rspec/expectations webmock/rspec mocha json timecop>.each { |lib| require lib }

RSpec.configure do |config|
  config.after(:each) do
    [:ACCOUNT_SID, :AUTH_TOKEN].each { |c| Twilio.instance_eval { remove_const c if const_defined? c } }
    WebMock.reset!
  end
  config.include WebMock::API
  config.mock_framework = :mocha
end

def canned_response(resp)
  File.new(File.join(File.expand_path(File.dirname __FILE__), 'support', 'responses', "#{resp}.json")).read
end

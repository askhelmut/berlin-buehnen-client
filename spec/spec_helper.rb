require 'simplecov'
SimpleCov.start
require 'berlin_buehnen'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# module LastRequest
#   def last_request
#     @last_request
#   end

#   def last_request=(request_signature)
#     @last_request = request_signature
#   end
# end

# WebMock.extend(LastRequest)
# WebMock.after_request do |request_signature, response|
#   WebMock.last_request = request_signature
# end

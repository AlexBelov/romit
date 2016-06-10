require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'vendor/'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'
require 'minitest/hell'
require 'shoulda/matchers'
require 'rr'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'vcr'
require 'webmock'
VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_hosts 'codeclimate.com'
end

module Minitest
  class Test
    parallelize_me!
  end
end

module Kernel
  alias context describe
end

require 'example_token'

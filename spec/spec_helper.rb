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
end

class Minitest::Test
  parallelize_me!
end

module Kernel
  alias_method :context, :describe
end

require 'example_token'

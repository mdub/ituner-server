require "rubygems"
require "bundler/setup"

require "rspec"
require "rack/test"
require 'rspec/rails/views/matchers'

require 'ituner/server/app'

Rspec.configure do |config|

  # config.mock_with :rr
  config.include Rack::Test::Methods

  def app
    ITuner::Server::App.new
  end

  config.after(:suite) do
    ITuner.itunes.pause
  end
  
end

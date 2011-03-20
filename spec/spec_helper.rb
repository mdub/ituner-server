require "rubygems"
require "bundler/setup"

require "rspec"

require 'capybara/rspec'
require 'rspec/rails/views/matchers'

require 'ituner/server/app'

Capybara.app = ITuner::Server::App

Rspec.configure do |config|

  # config.mock_with :rr

  config.after(:suite) do
    ITuner.itunes.pause
  end
  
end

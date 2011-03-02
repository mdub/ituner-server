require 'bundler'
Bundler::GemHelper.install_tasks

Bundler.setup

task "serve" do
  require 'ituner/server/app'
  Sinatra::Application.run!
end
# frozen_string_literal: true

if ENV['RACK_ENV'] != 'production'
  require 'dotenv'
  Dotenv.load
end

require 'sinatra'

class App < Sinatra::Application
  enable :sessions
  set :public_folder, File.dirname(__FILE__) + '/public'

  require_relative 'models/init'
  require_relative 'services/init'
  require_relative 'controllers/init'
  require_relative 'helpers/init'
end

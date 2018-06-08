# frozen_string_literal: true

class App < Sinatra::Application
  get '/' do
    erb :index
  end

  not_found do
    '~ 404 ~'
  end
end

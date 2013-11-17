#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'

module Fluency
  class App < Sinatra::Base
    register Sinatra::Reloader
    
    get '/' do
      @title = 'Home'
      erb :index
    end

    get '/stardate' do
      @title = 'Stardate Calculator'
      erb :stardate
    end
    
    get '/warp' do
      @title = 'Warp Speed Calculator'
      erb :warp
    end
    
    get '/novels' do
      @title = 'Star Trek Novels'
      erb :novels
    end
  end
end

if __FILE__ == $0
  Fluency::App.run! port: 9292
end
require 'dotenv/load'
require 'bundler'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index
  end
  
  post '/result' do
    # puts params
    @answer = params[:answer]
    if market_list(@answer)[0] != nil
      market_list(@answer).each do |market|
        Farmers_market.new(market)
      end
    end
    erb :result
  end
  
  post '/data' do
    erb :data
  end
end

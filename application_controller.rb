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
    @zip_code = params[:zip_code]
    if find_market(@zip_code)[0] != nil
      find_market(@zip_code).each do |market|
        Farmers_market.new(market)
      end
    end
    erb :result
  end
end

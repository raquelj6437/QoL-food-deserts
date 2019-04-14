require 'json'
require 'open-uri'

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def market_list(answer)
    fm = JSON.parse(open("https://data.ny.gov/api/views/xjya-f8ng/rows.json?accessType=DOWNLOAD"){ |x| x.read })
    if answer.numeric?
      return find_market(answer, fm)
    else
      return find_market_location(answer, fm)
    end
end

def find_market(zip_code, data)
    fm_arr = []
    data['data'].each do |market|
        if market[14] == zip_code.to_s
            fm_arr.push(market)
        end
    end
    if fm_arr.length == 0
        fm_arr.push(nil)
        fm_arr.push("There are no farmers markets in your area. We are working to expand the amount of farmers markets in New York.")
    end
    return fm_arr
end

def find_market_location(location,data)
    fm_arr = []
    data['data'].each do |market|
        if market[12] == location.to_s.capitalize
            fm_arr.push(market)
        end
    end
    if fm_arr.length == 0
        fm_arr.push(nil)
        fm_arr.push("There are no farmers markets in your area. We are working to expand the amount of farmers markets in New York.")
    end
    return fm_arr
end

class Farmers_market
    @@all = []
    
    def self.all
        @@all
    end

    def initialize(market, name = '', address = '', city = '', state = '', zipcode = '', contact_name = '', contact_number = '', website = '', time = '', days_open = '', snap = '')
        @name = market[9]
        @address = market[11]
        @city = market[12]
        @state = market[13]
        @zipcode = market[14]
        @contact_name = market[15]
        @contact_number = market[16]
        @website = market[17][0]
        @time = market[18]
        @days_open = market[19]
        if market[24] == 'N'
            @snap = 'No'
        else
            @snap = 'Yes'
        end
        
        @@all << self
    end
    
    attr_accessor :name, :address, :city, :state, :zipcode, :contact_name, :contact_number, :website, :time, :days_open, :snap
end
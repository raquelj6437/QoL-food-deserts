require 'json'
require 'open-uri'

def find_market(zip_code)
    fm = JSON.parse(open("https://data.ny.gov/api/views/xjya-f8ng/rows.json?accessType=DOWNLOAD"){ |x| x.read })
    fm_arr = []
    fm['data'].each do |market|
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
        @snap = market[24]
        
        @@all << self
    end
    
    attr_accessor :name, :address, :city, :state, :zipcode, :contact_name, :contact_number, :website, :time, :days_open, :snap
end

# fm = JSON.parse(open("https://data.ny.gov/api/views/xjya-f8ng/rows.json?accessType=DOWNLOAD"){ |x| x.read })

# fm['data'].each do |market|
#     puts market[24]
# end

# find_market(11209).each do |store|
#     Farmers_market.new(store)
# end

# Farmers_market.all.each do |market|
#     puts market.zipcode
# end
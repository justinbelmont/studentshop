class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessor :response, :parsed_response, :item, :price, :image, :discount

require 'rest_client'

CONVERSE_DISCOUNT = 0.20

def initialize
  response = RestClient.get 'http://www.kimonolabs.com/api/6wl3jrra?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  @parsed_response = JSON.parse(response)
  @data = @parsed_response["results"]["collection1"]
end

def retail_price(item)
  @retail_price = @data[item]["mens-shoes-prices"]
end

def product_image(item)
  @data[item]["mens-shoes-imgs"]["src"]
end

def product_title(item)
  @data[item]["mens-shoes-imgs"]["alt"]
end

def student_price(item)
  @retail_price = @data[item]["mens-shoes-prices"].gsub(/[^\d\.]/, '').to_i
  @student_price = @retail_price * (1 - CONVERSE_DISCOUNT)
  number_to_currency(@student_price.to_i)
end

def saved
  you_save = @price_as_num * CONVERSE_DISCOUNT
end

end

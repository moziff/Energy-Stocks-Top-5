require 'open-uri'
require "nokogiri"
require "pry"
require_relative "./stock.rb"

class Scraper

  attr_accessor :category_hash, :url

  def initialize(url)
    @url=url
    @category_hash={}
    # binding.pry
  end

  def index_scraper

    doc = Nokogiri::HTML(open(self.url))
    data = doc.css('tr[height*="25"]')

    data.each do |x|


      category_array=x.children[8].text.split(", ")
      percent_change=x.children[3].text #percent change of stock
      high=x.children[5].text
      low=x.children[6].text
      name=x.css('td[width*="400"]').text
      current_stock_value=x.children[1].text

       #name of stock
        # binding.pry

      category_array.each do |cate|

        if !(category_hash[cate])
          category_hash[cate]={"#{name}": Stock.new(name,category_array,percent_change,high,low,current_stock_value)}
        else
          category_hash[cate].merge!("#{name}": Stock.new(name,category_array,percent_change,high,low,current_stock_value))
        end
      end

    end
    # binding.pry
    category_hash

  end

end

require_relative '../../lib/scraper'
require_relative '../../lib/stock'

require "pry"
class CommandLineRunner
  attr_accessor :stocks, :category_hash
  def run
    puts "\n\nHello and welcome to Energy Stocks Top 5"
    user_input = nil
    cat_user_input=nil
    list
    until user_input=="exit" || cat_user_input=="exit"
      puts "\nWhat category of stocks would you like?"
      
      cat_user_input = gets.chomp
        if cat_user_input=="list"
          list
          puts "\nWhat category of stocks would you like?"
          cat_user_input = gets.chomp
        elsif cat_user_input == "exit"
          exit_input
        end
      display_stocks_with_input(cat_user_input)
      puts "\nWould you like to see these stocks based off of what parameter:"
      second_list
      user_input = gets.chomp
        if user_input=="percent change"
          top_percent_change(cat_user_input)
        elsif user_input=="high value"
          top_high(cat_user_input)
        elsif user_input=="low value"
          top_low(cat_user_input)
        elsif user_input=="current value"
          top_value(cat_user_input)
        end
    end
  end

  def list
    @stocks = Scraper.new("http://www.altenergystocks.com/comm/stocks.jsp")
    @category_hash=self.stocks.index_scraper
    @category_hash.keys.each do |category|
      puts "- #{category}\n"
    end
  end

  def second_list
    puts "\n- percent change \n- high value \n- low value \n- current value \n- reset \n- exit\n\n"
  end

  def display_stocks_with_input(input)
    self.category_hash.keys.each do |category|
      if input == category
        category_hash[input].values.each {|stock| stock.full_profile};
      end
    end
  end

  def top_percent_change(category)
    top_array=[]
    self.category_hash[category].each do |name,stock|
      top_array<<stock
    end
    top_array.delete_if{|element|element.percent_change=="N/A"}
    top_array=top_array.sort_by{|element| element.percent_change.to_f}.last(5)
    top_array.reverse.each do |element|
      puts "\n#{element.name}, #{element.percent_change} change in value\n"
    end
  end

  def top_high(category)
    top_array=[]
    self.category_hash[category].each do |name,stock|
      top_array<<stock
    end
    top_array.delete_if{|element|element.high=="N/A"}
    top_array=top_array.sort_by{|element| element.high.to_f}.last(5)
    top_array.reverse.each do |element|
      puts "\n#{element.name}, $#{element.high}\n"
    end
  end

  def top_low(category)
    top_array=[]
    self.category_hash[category].each do |name,stock|
      top_array<<stock
    end
    top_array.delete_if{|element|element.low=="N/A"}
    top_array=top_array.sort_by{|element| element.low.to_f}.first(5)
    top_array.each do |element|
      puts "\n#{element.name}, $#{element.low}\n"
    end
  end

  def top_value(category)
    top_array=[]
    self.category_hash[category].each do |name,stock|
      top_array<<stock
    end

    top_array.delete_if{|element|element.current_stock_value=="N/A"}
    top_array=top_array.sort_by{|element| element.current_stock_value.to_f}.last(5)
    top_array.reverse.each do |element|
      puts "#{element.name}, $#{element.current_stock_value}\n"
    end

  end

  def reset
    self.run
  end

  def exit_input
    exit
  end


end

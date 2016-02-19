
class Stock

attr_accessor :name, :percent_change, :high, :low, :category, :current_stock_value

    def initialize(name,category,percent_change,high,low,current_stock_value)
      @name=name
      @category=category
      @percent_change=percent_change
      @high=high
      @low=low
      @current_stock_value=current_stock_value
    end

    def full_profile
      puts "Name: #{name}
      Category: #{category}
      Current Trading Value: $#{current_stock_value}
      Percent Change: #{percent_change}
      High Trading Value: $#{high}
      Low Trading Value: $#{low}"
    end

end

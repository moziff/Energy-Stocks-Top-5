# require '../config/environment'
require_relative '../app/runners/command_line_runner.rb'
require_relative '../lib/scraper.rb'
require_relative '../lib/stock.rb'
CommandLineRunner.new.run

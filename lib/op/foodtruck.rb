require 'bundler'
require 'faraday'
# require_relative 'monocle/deal'
Bundler.require

puts "required"
module OP
  class Foodtruck
    def self.hello
      puts "world"
    end
  end
end

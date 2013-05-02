require 'bundler'
require 'faraday'
# require_relative 'monocle/deal'
Bundler.require

puts "required"
module Op
  module Foodtruck
    class Client
      def self.hello
        puts "world"
      end
    end
  end
end

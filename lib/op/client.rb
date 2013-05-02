require 'bundler'
require 'faraday'

module Op
  module Foodtruck
    class Client
      attr_accessor :oauth_token, :api_tld, :api_version
      FOODTRUCK_URL = Op::Foodtruck::FOODTRUCKS[:api_tld]
      API_VERSION = "v1"

      def initialize(oauth_token, api_tld=nil, api_version=nil)
        api_tld          ||= FOODTRUCK_URL
        api_version      ||= api_version
        self.oauth_token   = oauth_token
      end

      def get(path, options={})
        json_to_hashie_mash(query_trucks_api(generic_url(path, options)))
      end

      def post(path, options={})
        json_to_hashie_mash(post_trucks_api(generic_url(path), options))
      end

      def get_trucks(options = {})
        result = json_to_hashie_mash(query_trucks_api(truck_search_url(options)))

        construct_pagination(result.trucks, options[:page] || 1, 20, result.total_entries)
      end

      def get_cities
        json_to_hashie_mash(query_trucks_api(cities_url))
      end

      def get_truck(id)
        json_to_hashie_mash(query_trucks_api(truck_url(id)))
      end

    private

      def generic_url(path, options)
        [base_url, path, oauth_token_to_param, parameterize(options)].join("")
      end

      def truck_url(id)
        [base_url, "trucks/#{id}", oauth_token_to_param].join("")
      end

      def json_to_hashie_mash(json)
        Hashie::Mash.new(JSON.parse(json))
      end

      def cities_url
        [base_url, "cities/", oauth_token_to_param].join("")
      end

      # options: 
      # city_id=1
      # tags=bbq,asian
      # s=searchterm
      # city_name=dc
      # page=1
      def truck_search_url(options = {})
        [base_url, "trucks/", oauth_token_to_param, parameterize(options)].join("")
      end

      def base_url
        [FOODTRUCK_URL, "api/", API_VERSION, "/"].join("")
      end

      def oauth_token_to_param
        "?access_token=#{self.oauth_token}"
      end

      def parameterize(params)
        return if params.empty?
        "&#{URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))}"
      end

      def construct_pagination(results, current_page, per_page, total_entries)
        WillPaginate::Collection.create(current_page, per_page, total_entries) do |pager|
          pager.replace results
        end
      end

      def post_trucks_api(url, options)
        result = Faraday.post(url, options)
        if result.status == 201
          "success"
        else
          raise "Query with URL: #{url} resulted in a #{result.status} error"
        end
      end

      def query_trucks_api url
        result = Faraday.get(url)
        if result.status == 200
          result.body
        else
          raise "Query with URL: #{url} resulted in a #{result.status} error"
        end
      end

    end

  end

end

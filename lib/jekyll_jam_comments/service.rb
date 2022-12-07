# frozen_string_literal: true

require "pry"
require "httparty"

module Jekyll
  module JamComments
    class Service
      attr_reader :base_url, :environment, :domain, :api_key, :client

      def initialize(
        domain:,
        api_key:,
        base_url: nil,
        environment: nil,
        client: HTTParty
      )
        @client = client
        @domain = domain
        @api_key = api_key
        @base_url = base_url || "https://go.jamcomments.com"
        @environment = environment || "production"
      end

      def fetch(path:)
        options = {
          :query   => {
            :path   => formatted_path(path),
            :domain => domain,
            :stub   => stub_value,
          },
          :headers => {
            :Authorization => "Bearer #{api_key}",
            :Accept        => "application/json",
            :'X-Platform'  => "jekyll",
          },
        }

        send_request(options)
      end

      private

      def send_request(options)
        response = client.get(endpoint, options)

        if response.code == 401
          raise "Oh no! It looks like your credentials for JamComments are incorrect."
        end

        if response.code != 200
          raise "Oh no! JamComments request failed. Please try again. Status: #{response.code}"
        end

        response.body
      end

      def stub_value
        return "true" if environment != "production"

        nil
      end

      def endpoint
        "#{base_url}/api/markup"
      end

      def formatted_path(path)
        path.empty? ? "/" : path
      end
    end
  end
end

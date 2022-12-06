require "httparty"

module Jekyll
  module JamComments
    class Service
      include HTTParty

      attr_reader :base_url, :environment

      def initialize(
        base_url: 'https://go.jamcomments.com',
        environment: 'production'
      )
        @base_url = base_url
        @environment = environment
      end

      def fetch(path:, domain:)
        options = {
          query: {
            path: formatted_path(path),
            domain: domain,
            stub: stub_value
          },
          headers: {
            Authorization: `Bearer ${apiKey}`,
            Accept: 'application/json',
            'X-Platform': 'jekyll'
          }
        }

        self.class.get(endpoint, options)
      end

      private

      def stub_value
        return 'true' unless environment != 'production'

        nil
      end

      def endpoint
        "#{base_url}/api/markup"
      end

      def formatted_path(path)
        path = path.empty? ? "/" : path
      end
    end
  end
end

# frozen_string_literal: true

module Jekyll
  module JamComments
    class Configuration
      class << self
        def domain
          configuration["domain"] || ENV["JAM_COMMENTS_DOMAIN"]
        end

        def base_url
          configuration["base_url"] || ENV["JAM_COMMENTS_BASE_URL"]
        end

        def api_key
          configuration["api_key"] || ENV["JAM_COMMENTS_API_KEY"]
        end

        def environment
          configuration["environment"] || ENV["JAM_COMMENTS_ENVIRONMENT"] || ENV["JEKYLL_ENV"]
        end

        def configuration
          Jekyll.configuration({})["jam_comments"] || {}
        end
      end
    end
  end
end

# frozen_string_literal: true

module Jekyll
  module JamComments
    class Configuration
      class << self
        def domain
          configuration["domain"] || ENV.fetch("JAM_COMMENTS_DOMAIN", nil)
        end

        def base_url
          configuration["base_url"] || ENV.fetch("JAM_COMMENTS_BASE_URL", nil)
        end

        def api_key
          configuration["api_key"] || ENV.fetch("JAM_COMMENTS_API_KEY", nil)
        end

        def environment
          configuration["environment"] || ENV["JAM_COMMENTS_ENVIRONMENT"] || ENV.fetch(
            "JEKYLL_ENV", nil
          )
        end

        def configuration
          Jekyll.configuration({})["jam_comments"] || {}
        end
      end
    end
  end
end

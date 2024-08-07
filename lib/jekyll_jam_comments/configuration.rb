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

        def copy
          original_copy = configuration["copy"] || {}

          {
            :copy_confirmation_message => original_copy["confirmation_message"],
            :copy_submit_button        => original_copy["submit_button"],
            :copy_name_placeholder     => original_copy["name_placeholder"],
            :copy_email_placeholder    => original_copy["email_placeholder"],
            :copy_comment_placeholder  => original_copy["comment_placeholder"],
            :copy_write_tab            => original_copy["write_tab"],
            :copy_preview_tab          => original_copy["preview_tab"],
            :copy_auth_button          => original_copy["auth_button"],
            :copy_log_out_button       => original_copy["log_out_button"],
          }.compact
        end

        def configuration
          Jekyll.configuration({})["jam_comments"] || {}
        end
      end
    end
  end
end

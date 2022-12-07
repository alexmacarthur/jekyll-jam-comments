# frozen_string_literal: true

require "jekyll"
require_relative "./jekyll_jam_comments/service"
require_relative "./jekyll_jam_comments/configuration"

module Jekyll
  module JamComments
    class Tag < Liquid::Tag
      attr_reader :path, :markup

      CLIENT_SCRIPT_URL = "https://unpkg.com/@jam-comments/client@1.0.4/dist/index.umd.js"

      def initialize(tag_name, path, tokens)
        super

        @path = path
      end

      def render(context)
        path = context["page"] && context["page"]["url"]
        markup = service.fetch(:path => path)

        "
          #{markup}
          <script src=\"#{CLIENT_SCRIPT_URL}\"></script>
          <script>
            const root = document.querySelector('[data-jam-comments-component=\"shell\"]');
            JamComments.initialize(root);
          </script>
        "
      end

      def service
        @service ||= Service.new(
          :domain      => Jekyll::JamComments::Configuration.domain,
          :api_key     => Jekyll::JamComments::Configuration.api_key,
          :base_url    => Jekyll::JamComments::Configuration.base_url,
          :environment => Jekyll::JamComments::Configuration.environment
        )
      end

      def configuration
        Jekyll.configuration({})["jam_comments"]
      end
    end
  end
end

Liquid::Template.register_tag("jam_comments", Jekyll::JamComments::Tag)

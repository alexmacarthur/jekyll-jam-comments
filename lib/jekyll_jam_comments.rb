# frozen_string_literal: true

require "jekyll"
require_relative "./jekyll_jam_comments/service"

module Jekyll
  module JamComments
    class Tag < Liquid::Tag
      attr_reader :path, :markup

      CLIENT_SCRIPT_URL = "https://unpkg.com/@jam-comments/client@1.0.4/dist/index.umd.js"

      def initialize(tag_name, path, tokens)
        super

        @path = path
        @markup = service.fetch(:path => path)
      end

      def render(_context)
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
          :domain      => configuration["domain"],
          :api_key     => configuration["api_key"],
          :base_url    => configuration["base_url"],
          :environment => configuration["environment"]
        )
      end

      def configuration
        Jekyll.configuration({})["jam_comments"]
      end
    end
  end
end

Liquid::Template.register_tag("jam_comments", Jekyll::JamComments::Tag)

# frozen_string_literal: true

require "jekyll"
require_relative "./jekyll_jam_comments/service"
require_relative "./jekyll_jam_comments/configuration"

module Jekyll
  module JamComments
    class Tag < Liquid::Tag
      attr_reader :path, :markup

      def initialize(tag_name, path, tokens)
        super

        @path = path
      end

      def render(context)
        path = context["page"] && context["page"]["url"]
        markup = service.fetch(:path => path)

        "
          #{markup}
          <script>
            window.jcAlpine.start();
          </script>
        "
      end

      def service
        @service ||= Service.new(
          :domain      => Jekyll::JamComments::Configuration.domain,
          :api_key     => Jekyll::JamComments::Configuration.api_key,
          :base_url    => Jekyll::JamComments::Configuration.base_url,
          :environment => Jekyll::JamComments::Configuration.environment,
          :copy        => Jekyll::JamComments::Configuration.copy
        )
      end

      def configuration
        Jekyll.configuration({})["jam_comments"]
      end
    end
  end
end

Liquid::Template.register_tag("jam_comments", Jekyll::JamComments::Tag)

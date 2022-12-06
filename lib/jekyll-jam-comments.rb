require "jekyll"
require "pry"
require_relative "./jekyll-jam-comments/service"

module Jekyll
  module JamComments
    class Tag < Liquid::Tag

      attr_reader :path

      def initialize(tag_name, path, tokens)
        super

        @path = path
        # @markup = Service.new.fetch(path: "/my-path", domain: "my-domain")
      end

      def render(context)

        binding.pry

        # Jekyll.configuration({})["jam_comments"]["domain"]
        # Jekyll.configuration({})["jam_comments"]["api_key"]
        # Jekyll.configuration({})["jam_comments"]["base_url"]
        # Jekyll.configuration({})["jam_comments"]["environment"]
        # "#{path} #{Time.now}"
      end
    end
  end
end

Liquid::Template.register_tag('jam_comments', Jekyll::JamComments::Tag)

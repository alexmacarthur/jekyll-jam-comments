# frozen_string_literal: true

describe Jekyll::JamComments::Tag do
  describe("#render") do
    it("renders correctly") do
      allow_any_instance_of(described_class).to receive(:configuration).and_return({
        "domain"      => "example.com",
        "api_key"     => "abc123",
        "base_url"    => nil,
        "environment" => nil,
      })
      allow_any_instance_of(Jekyll::JamComments::Service)
        .to receive(:fetch)
        .and_return("<div>test markup</div>")

      liquid = <<-LIQUID
        {% jam_comments %}
      LIQUID

      rendered = Liquid::Template.parse(liquid).render

      expect(rendered).to include("<div>test markup</div>")
      expect(rendered).to match(%r!<script src="https://unpkg\.com/@jam-comments/client@(.*)/dist/index\.umd\.js"></script>!)
    end
  end
end

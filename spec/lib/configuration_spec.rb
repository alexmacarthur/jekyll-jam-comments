# frozen_string_literal: true

describe Jekyll::JamComments::Configuration do
  before(:each) do
    ENV["JAM_COMMENTS_ENVIRONMENT"] = "production"
    ENV["JAM_COMMENTS_DOMAIN"] = "macarthur.me"
    ENV["JAM_COMMENTS_API_KEY"] = "xyz"
    ENV["JAM_COMMENTS_BASE_URL"] = "https://go.jamcomments.com"
  end

  describe("set in config") do
    it("returns correct values") do
      allow(described_class).to receive(:configuration).and_return({
        "domain"      => "example.com",
        "api_key"     => "abc123",
        "base_url"    => "http://localhost",
        "environment" => "development",
      })

      expect(described_class.domain).to eq("example.com")
      expect(described_class.base_url).to eq("http://localhost")
      expect(described_class.api_key).to eq("abc123")
      expect(described_class.environment).to eq("development")
    end
  end

  describe("set in ENV") do
    it("returns correct values") do
      allow(described_class).to receive(:configuration).and_return({})

      expect(described_class.domain).to eq("macarthur.me")
      expect(described_class.base_url).to eq("https://go.jamcomments.com")
      expect(described_class.api_key).to eq("xyz")
      expect(described_class.environment).to eq("production")
    end

    it("falls back to JEKYLL_ENV") do
      allow(described_class).to receive(:configuration).and_return({})
      ENV["JEKYLL_ENV"] = "jekyll_env"
      ENV["JAM_COMMENTS_ENVIRONMENT"] = nil

      expect(described_class.environment).to eq("jekyll_env")
    end
  end
end

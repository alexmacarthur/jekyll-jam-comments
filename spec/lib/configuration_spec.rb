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

  describe("copy") do
    it("returns correct values") do
      allow(described_class).to receive(:configuration).and_return({
        "copy" => {
          "confirmation_message" => "Thanks for the comment!",
          "submit_button"        => "Post Comment",
          "name_placeholder"     => "Your Name",
          "email_placeholder"    => "Your Email",
          "comment_placeholder"  => "Your Comment",
          "write_tab"            => "Write",
          "preview_tab"          => "Preview",
          "auth_button"          => "Log In",
          "log_out_button"       => "Log Out",
        },
      })

      expect(described_class.copy).to eq({
        :copy_confirmation_message => "Thanks for the comment!",
        :copy_submit_button        => "Post Comment",
        :copy_name_placeholder     => "Your Name",
        :copy_email_placeholder    => "Your Email",
        :copy_comment_placeholder  => "Your Comment",
        :copy_write_tab            => "Write",
        :copy_preview_tab          => "Preview",
        :copy_auth_button          => "Log In",
        :copy_log_out_button       => "Log Out",
      })
    end

    it("returns nil for missing keys") do
      allow(described_class).to receive(:configuration).and_return({})

      expect(described_class.copy).to eq({})
    end
  end
end

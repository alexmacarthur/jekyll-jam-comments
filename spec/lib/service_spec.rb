# frozen_string_literal: true

describe Jekyll::JamComments::Service do
  let(:client) { class_double("client") }

  describe "#fetch" do
    context "production" do
      it "makes correct request" do
        instance = described_class.new(
          :domain  => "example.com",
          :api_key => "abc123",
          :client  => client
        )

        expect(client).to receive(:get).with(
          "https://go.jamcomments.com/api/markup",
          {
            :query   => hash_including(
              :path   => "/path",
              :domain => "example.com",
              :stub   => nil
            ),
            :headers => hash_including(
              :Authorization => "Bearer abc123",
              :Accept        => "application/json",
              :'X-Platform'  => "jekyll"
            ),
          }
        )

        instance.fetch(:path => "/path")
      end
    end

    context "development" do
      it "makes correct request" do
        instance = described_class.new(
          :base_url    => "http://localhost",
          :domain      => "example.com",
          :api_key     => "abc123",
          :client      => client,
          :environment => "development"
        )

        expect(client).to receive(:get).with(
          "http://localhost/api/markup",
          {
            :query   => hash_including(
              :path   => "/path",
              :domain => "example.com",
              :stub   => "true"
            ),
            :headers => hash_including(
              :Authorization => "Bearer abc123",
              :Accept        => "application/json",
              :'X-Platform'  => "jekyll"
            ),
          }
        )

        instance.fetch(:path => "/path")
      end
    end
  end
end

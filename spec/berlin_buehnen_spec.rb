require "spec_helper"

describe BerlinBuehnen do
  let(:username){ "test" }
  let(:api_key){ "test" }

  it "raises ArgumentError when initialized with no options" do
    expect{ BerlinBuehnen.new }.to raise_error(ArgumentError)
  end

  context 'initialized with a api_key' do
    subject{BerlinBuehnen.new(username: username, :api_key => api_key)}

    describe "#api_key" do
      it "returns the initialized value" do
        expect(subject.api_key).to eq(api_key)
      end
    end

    describe "#options" do
      it "includes api:key" do
        expect(subject.options).to include(:api_key)
      end
    end

    describe "#api_username" do
      it { expect(subject.api_username).to eq username }
    end

    describe "#site" do
      it { expect(subject.site).to eq("www.berlin-buehnen.de") }
    end

    describe "#host" do
      it { expect(subject.host).to eq("www.berlin-buehnen.de") }
    end

    describe "#api_language" do
      it { expect(subject.api_language).to eq "de" }
    end

    describe "#api_host" do
      it { expect(subject.api_host).to eq("www.berlin-buehnen.de") }
    end

    describe "#api_url" do
      it { expect(subject.api_url).to eq("www.berlin-buehnen.de/de/api/v1")}
    end

    [:get].each do |method|
      describe "##{method}" do
        it "accepts urls as path and rewrite them" do
          expect(BerlinBuehnen::Client).to receive(method).with('http://www.berlin-buehnen.de/de/api/v1/production/123', { query: { format: "json", username: username, api_key: api_key}})

          subject.send(method, "/production/123")
        end

        it "accepts additional query parameters" do
          expect(BerlinBuehnen::Client).to receive(method).with('http://www.berlin-buehnen.de/de/api/v1/production/123', {query: { limit: 2, format: "json", username: username, api_key: api_key}})
          subject.send(method, '/production/123', limit: 2)
        end

        it "when requesting a single resource wraps the response object in a Response" do
          VCR.use_cassette("location") do
            expect(subject.send(method, '/location/68')).to be_an_instance_of BerlinBuehnen::Response
          end
        end

        it "when requesting collections wraps the response object in a ListResponse" do
          VCR.use_cassette("locations") do
            expect(subject.send(method, '/location/')).to be_an_instance_of BerlinBuehnen::ListResponse
          end
        end
      end
    end
  end

end

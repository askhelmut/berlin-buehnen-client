require "spec_helper"

describe BerlinBuehnen do
  let(:username){ "askhelmut" }
  let(:api_key){ "f62af108a3e0bc3743c9416a8b229cdabdad483b" }

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

    [:get, :head].each do |method|
      describe "##{method}" do
        xit "accepts urls as path and rewrite them" do
          expect(BerlinBuehnen::Client).to receive(method).with('http://www.berlin-buehnen.de/de/api/v1/event/123', { query: { format: "json", username: username, api_key: api_key}})

          subject.send(method, "/event/123")
        end

        xit "accepts additional query parameters" do
          expect(BerlinBuehnen::Client).to receive(method).with('http://www.berlin-buehnen.de/de/api/v1/event/123', {query: { limit: 2, format: "json", username: username, api_key: api_key}})
          subject.send(method, '/event/123', limit: 2)
        end

        it "wraps the response object in a Response", :focus do
          # stub_request(method, "http://www.berlin-buehnen.de/de/api/v1/event/123?api_key=key&format=json").
          #   with(:headers => {'User-Agent'=>'ASK HELMUT BerlinBuehnen API Wrapper 0.0.1'}).
          #   to_return(:body => '{"title": "bla"}', :headers => {:content_type => "application/json"})
          # stub_request(method, "http://www.berlin-buehnen.de/de/api/v1/location/?api_key=key&format=json&username=test").with(:headers => {'User-Agent'=>'ASK HELMUT BerlinBuehnen API Wrapper 0.0.1'}).to_return(:status => 200, :body => "", :headers => {})

          expect(subject.send(method, '/location/')).to be_an_instance_of BerlinBuehnen::Response
        end
      end
    end
  end

end

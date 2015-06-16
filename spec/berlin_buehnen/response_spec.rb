require "spec_helper"

describe BerlinBuehnen::Response do

  subject do
    VCR.use_cassette("location") do
      BerlinBuehnen.new(username: "askhelmut", api_key: "f62af108a3e0bc3743c9416a8b229cdabdad483b").get('/location/68')
    end
  end

  describe "#data" do
    it { expect(subject.data).to be_kind_of Hash }
  end

end

require "spec_helper"

describe BerlinBuehnen::Response do

  subject do
    VCR.use_cassette("location") do
      BerlinBuehnen.new(username: "test", api_key: "test").get('/location/68')
    end
  end

  describe "#data" do
    it { expect(subject.data).to be_kind_of Hash }
  end

end

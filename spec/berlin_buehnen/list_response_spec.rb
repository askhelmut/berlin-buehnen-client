require "spec_helper"

describe BerlinBuehnen::ListResponse do

  subject do
    VCR.use_cassette("locations") do
      BerlinBuehnen.new(username: "askhelmut", api_key: "f62af108a3e0bc3743c9416a8b229cdabdad483b").get('/location/')
    end
  end

  describe "#data" do
    it { expect(subject.data).to be_kind_of Array }
  end

  describe "next?" do
    it { expect(subject.next?).to be false }
  end

  describe "previous?" do
    it { expect(subject.previous?).to be false }
  end

  describe "#total_count" do
    it "returns the total count of unpagianted objects" do
      expect(subject.total_count).to eq 85
    end
  end

  describe "#limit" do
    it "returns the current limit" do
      expect(subject.limit).to eq 100
    end
  end

  describe "#offset" do
    it "returns the current offset" do
      expect(subject.offset).to eq 0
    end
  end

end

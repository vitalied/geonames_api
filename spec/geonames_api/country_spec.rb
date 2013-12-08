require "spec_helper"

module GeoNamesAPI
  describe Country do

    subject do
      described_class.find "CA"
    end

    it "can download and unpack the csv" do
      expect(subject.postal_code_csv.size).to be > 0
    end

  end
end
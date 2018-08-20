require "spec_helper"

RSpec.describe Xrates::Config do

  describe "Fixer#access_key" do
    it "default value is 568ce8a8fe8bb805ab5b84e2ce2a47c8" do
      Xrates::Config::Fixer.new.access_key = "568ce8a8fe8bb805ab5b84e2ce2a47c8"
    end
  end

  describe "Fixer#access_key=" do
    it "can set value" do
      fixer_config = Xrates::Config::Fixer.new
      fixer_config.access_key = 7
      expect(fixer_config.access_key).to eq(7)
    end
  end

  describe "Fixer#configure" do

    before do
      Xrates::Config::Fixer.configure do |config|
        config.access_key = 212
      end
    end

    it "test config fixer" do
      fixer = Xrates::Adapter::Fixer.new
      expect(fixer.config.access_key).to eq(212)
    end
  end
end

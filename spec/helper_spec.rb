require 'spec_helper'

describe ApplicationHelper, type: :helper do
  
  before :all do
    @empty_block = Proc.new{}
  end

  describe '#cache' do
    it "should accept an arbitrary ActiveRecord's class name" do
      expect{ helper.cache(ArbitraryRecord, &@empty_block) }.not_to raise_error
    end

    it "should accept an arbitrary ActiveRecord's instance " do
      expect{ helper.cache(ArbitraryRecord.take, &@empty_block) }.not_to raise_error
    end

    it "should accept an arbitrary ActiveRecord's relation" do
      expect{ helper.cache(ArbitraryRecord.where(true), &@empty_block) }.not_to raise_error
    end
  end
end
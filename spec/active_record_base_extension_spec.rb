require 'spec_helper'

describe "An arbitrary ActiveRecord's" do
  it 'class should respond to cache_key' do
    ArbitraryRecord.should respond_to(:cache_key)
  end

  it 'instance should respond to cache_key' do
    FactoryGirl.create(:arbitrary_record).should respond_to(:cache_key)
  end
end

describe 'An ActiveRecord cache_key for all models' do
  # Initialize some data  
  before(:all) do
    (1 + rand(10)).times {FactoryGirl.create :arbitrary_record}
  end

  it 'should be the same if there was no change in the records' do
    old_cache_key = ArbitraryRecord.cache_key
    # Check a random number of times
    (1 + rand(10)).times do
      new_cache_key = ArbitraryRecord.cache_key
      old_cache_key.should be_eql new_cache_key
    end
  end

  describe 'should update when' do
    it 'a new record is inserted' do
      old_cache_key = ArbitraryRecord.cache_key
      FactoryGirl.create :arbitrary_record
      old_cache_key.should_not be_eql ArbitraryRecord.cache_key
    end

    it 'a record is destroyed' do
      old_cache_key = ArbitraryRecord.cache_key
      ArbitraryRecord.take.destroy!
      old_cache_key.should_not be_eql ArbitraryRecord.cache_key
    end

    it 'a record is updated' do
      old_cache_key = ArbitraryRecord.cache_key
      record = ArbitraryRecord.take
      record.name = record.name.reverse
      record.save
      ArbitraryRecord.set_callback :commit, :after do
        old_cache_key.should_not be_eql ArbitraryRecord.cache_key
      end
    end
  end
end
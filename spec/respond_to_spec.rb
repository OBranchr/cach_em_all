require 'spec_helper'

describe "An arbitrary ActiveRecord's" do
  # Initialize some data  
  before :all do
    3.times {FactoryGirl.create :arbitrary_record}
  end

  it 'class should respond to cache_key' do
    ArbitraryRecord.should respond_to(:cache_key)
  end

  it 'instance should respond to cache_key' do
    ArbitraryRecord.take.should respond_to(:cache_key)
  end

  it 'relation should respond to cache_key' do
    ArbitraryRecord.where(true).should respond_to(:cache_key)
  end
end

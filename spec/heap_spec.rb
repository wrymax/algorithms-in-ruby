require 'spec_helper'

describe "empty heap" do
  before(:each) do
    @heap = DataStructure::Heap.new
  end

  it "should return size 0" do
    @heap.size.should == 0
  end

  it 'can push' do
    @heap.push(1000)[1].should == 1000
    @heap.size.should == 1
  end

  it 'can pop' do
    @heap.pop
    @heap.size.should == 0
  end

  it 'has root' do
    @heap.root.should be_nil
  end

  it 'has last' do
    @heap.last.should be_nil
  end
end

describe "non-empty heap" do
  before(:each) do
    @heap = DataStructure::Heap.new([5, 1, 7, 4, 9, 12, 455, 34, 90])
  end

  it "should adjust to max-heap" do
    @heap[1].should == 455
    # binding.pry
  end

  it "can sort" do
    @heap.sort.should == [5, 1, 7, 4, 9, 12, 455, 34, 90].sort.reverse
  end

  it 'can push' do
    @heap.push(1000)[1].should == 1000
    @heap.size.should == 10
  end

  it 'can pop' do
    @heap.pop
    @heap.size.should == 8
  end

  it 'has root' do
    @heap.root.should == 455
  end

  it 'has last' do
    @heap.last.should == 4
  end
end

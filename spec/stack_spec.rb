require 'spec_helper'

shared_examples "empty stack" do
  it "should return nil when #pop" do
    @stack.pop.should be_nil
  end

  it "should return nil when #next" do
    @stack.next.should be_nil
  end

  it "should return size when #push" do
    @stack.push(1).should == @stack.size
  end

  it "should return true when #empty?" do
    @stack.empty?.should be_true
  end

  it "should return 0 when #size" do
    @stack.size.should be_zero
  end

  it "should return nil when #each" do
    @stack.each.should be_nil
  end
end

shared_examples "non-empty stack" do
  it "should return the next element when #pop" do
    next_element = @stack.next
    size = @stack.size
    @stack.pop.should == next_element
    @stack.size.should == size - 1
  end

  it "should return 3 when #next" do
    @stack.next.should == 3
  end

  it "should return size when #push" do
    @stack.push(1).should == @stack.size
  end

  it "should return false when #empty?" do
    @stack.empty?.should be_false
  end

  it "should return 3 when #size" do
    @stack.size.should == 3
  end

  it "should each iterate the stack" do
    arr = []
    @stack.each do |element|
      arr.push element
    end
    arr.should == [3, 2, 1]
  end
end

describe "for empty stack" do
  before(:each) do
    @stack = DataStructure::Stack.new
  end

  it_should_behave_like "empty stack"
end

describe "for non-empty stack" do
  before(:each) do
    @stack = DataStructure::Stack.new([1, 2, 3])
  end

  it_should_behave_like "non-empty stack"
end

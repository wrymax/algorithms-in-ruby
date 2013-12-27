require 'spec_helper'

describe "empty binary tree" do
  before(:each) do
    @tree = DataStructure::BinaryTree.new
  end

  it "should have a root of nil" do
    @tree.root.should be_nil
  end

  it "should have a size of 0" do
    @tree.size.should be_zero
  end

  it "can push new element into a tree" do
    @tree.push 10
    @tree.size.should == 1
    @tree.root.should == 10

    @tree.push 15
    @tree.size.should == 2

    @tree.push 20
    @tree.size.should == 3

    arr = []
    @tree.level_order_traverse do |node|
      arr.push node
    end

    arr.should == [10, 15, 20]
  end

  it "should return nil when pre_order_traverse" do
    @tree.pre_order_traverse.should be_nil
  end

  it "should return nil when in_order_traverse" do
    @tree.in_order_traverse.should be_nil
  end

  it "should return nil when post_order_traverse" do
    @tree.post_order_traverse.should be_nil
  end

end

describe "non-empty binary tree" do
  before :each do
    @arr = [4, 1, 5, 8, 12, 90, 100, 3, 54, 10]
    @tree = DataStructure::BinaryTree.new(@arr)
  end

  it "should return size" do
    @tree.size.should == @arr.size
  end

  it "should have a root" do
    @tree.root.should == @arr.first
  end

  it "can push new element into a tree" do
    @tree.push 1000
    @tree.size.should == 11

    arr = []
    @tree.level_order_traverse do |node|
      arr.push node
    end

    arr.should == [4, 1, 5, 8, 12, 90, 100, 3, 54, 10, 1000]
  end

  it "can pre_order_traverse with a block" do
    arr = []
    @tree.pre_order_traverse do |node|
      arr.push node
    end

    arr.should == [4, 1, 8, 3, 54, 12, 10, 5, 90, 100]
  end

  it "can in_order_traverse with a block" do
    arr = []
    @tree.in_order_traverse do |node|
      arr.push node
    end

    arr.should == [3, 8, 54, 1, 10, 12, 4, 90, 5, 100]
  end

  it "can post_order_traverse with a block" do
    arr = []
    @tree.post_order_traverse do |node|
      arr.push node
    end

    arr.should == [3, 54, 8, 10, 12, 1, 90, 100, 5, 4]
  end

  it "can level_order_traverse with a block" do
    arr = []
    @tree.level_order_traverse do |node|
      arr.push node
    end

    arr.should == [4, 1, 5, 8, 12, 90, 100, 3, 54, 10]
  end

end

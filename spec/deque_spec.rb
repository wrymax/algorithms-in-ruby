require 'spec_helper'

shared_examples "empty deque" do
	it "should return nil when #pop" do
		@deque.pop_back.should be_nil
		@deque.pop_front.should be_nil
	end

	it "should return nil when #push" do
		@deque.push_back('a').should == 1
		@deque.back.should == 'a'
		@deque.push_front('b').should == 2
		@deque.front.should == 'b'
	end

	it "should return nil when each_forward" do
		@deque.each_forward.should be_nil
	end

	it "should return nil when each_backward" do
		@deque.each_backward.should be_nil
	end

	it "should return true when #empty?" do
		@deque.empty?.should be_true
	end
end

shared_examples "non-empty deque" do
	it "should return value when #back" do
		@deque.back.should == 3
	end

	it "should return value when #pop" do
		back = @deque.back
		front = @deque.front
		@deque.pop_back.should == back
		@deque.pop_front.should == front
	end

	it "should cut element from back when #pop_back" do
		@deque.pop_back.should == 3
		@deque.size.should == 2
	end

	it "should cut element from front when #pop_front" do
		@deque.pop_front.should == 1
		@deque.size.should == 2
	end

	it "can each forward every element" do
		arr = []
		@deque.each_forward do |element|
			arr.push element
		end

		arr.should == [1, 2, 3]
	end

	it "can each backward every element" do
		arr = []
		@deque.each_backward do |element|
			arr.push element
		end

		arr.should == [3, 2, 1]
	end

	it "should return false when #empty?" do
		@deque.empty?.should be_false
	end

end

describe "for empty deque" do
	before(:each) do
		@deque = DataStructure::Deque.new
	end

	it_should_behave_like "empty deque"
end

describe "for non-empty deque" do
	before(:each) do
		@deque = DataStructure::Deque.new([1, 2, 3])
	end

	it_should_behave_like "non-empty deque"
end

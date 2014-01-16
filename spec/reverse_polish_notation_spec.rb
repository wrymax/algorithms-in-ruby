require 'spec_helper'

describe MyAlgorithms::Calculator do
  before(:each) do
    @calculator = MyAlgorithms::Calculator.new
    @e1 = "10 + 30/(5 + 5) * 2 + 1"
    @e2 = "20 - 30/(10 + 5 * 4) * 6 + 1"
    @e3 = '1+2+3+4+5'
    @e4 = '1*2*(3+4)*5'
    @e5 = '1 + 2*((3+4)*5 -20)'
    @e6 = '1.5 + 2.5*((3.2+4.3)*5 -20)'
  end

  it "can do elementary arithmetic with reverse polish notation" do
    @calculator.run(@e1).should == 17
    @calculator.run(@e2).should == 15
    @calculator.run(@e3).should == 15
    @calculator.run(@e4).should == 70
    @calculator.run(@e5).should == 31
    @calculator.run(@e6).should == 45.25
  end
end

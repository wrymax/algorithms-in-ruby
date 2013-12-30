require 'spec_helper'

describe "undirected graph" do
  before :each do
    @file = File.open('spec/docs/undirected_graph')
    @graph = DataStructure::UndirectedGraph.new(@file)
  end

  it "should access all vertexes and edges" do
    @graph.vertexes.should == Set.new(['Mobile', 'E-Commerce', 'Social Network', 'Security', 'Hardware'])

    @graph.adjacencies_of('Mobile').to_set.should == Set.new(['E-Commerce', 'Social Network'])
    @graph.adjacencies_of('Hardware').to_set.should == Set.new(['Security', 'Social Network'])

    @graph.find_vertex('Hardware').weight_with('Social Network').should == 10
    @graph.find_vertex('Mobile').weight_with('Social Network').should == 150
  end
end

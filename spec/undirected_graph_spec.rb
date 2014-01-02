require 'spec_helper'

describe "undirected graph" do
  before :each do
    @file = File.open('spec/docs/undirected_graph')
    @graph = DataStructure::UndirectedGraph.new(@file)
    @vertex_set = Set.new(['Mobile', 'E-Commerce', 'Social Network', 'Security', 'Hardware'])
  end

  it "should access all vertexes" do
    @graph.vertexes.should == @vertex_set
  end

  it "can get adjacencies of a vertex" do
    @graph.adjacencies_of('Mobile').to_set.should == Set.new(['E-Commerce', 'Social Network'])
    @graph.adjacencies_of('Hardware').to_set.should == Set.new(['Security', 'Social Network'])
  end

  it "can get weight between two vertexes" do
    @graph.find_vertex('Hardware').weight_with('Social Network').should == 10
    @graph.find_vertex('Mobile').weight_with('Social Network').should == 150
  end

  it "can depth first traverse all vertexes" do
    set = Set.new
    @graph.depth_first_traverse_from('Mobile') do |vertex|
      set.add vertex
    end

    set.should == @vertex_set
  end
end

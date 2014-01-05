require 'spec_helper'

describe "undirected graph" do
  INFINITY = 62235

  before :each do
    @file = File.open('spec/docs/undirected_graph')
    @graph = DataStructure::UndirectedGraph.new(@file)
    @vertex_set = Set.new(['Mobile', 'E-Commerce', 'Social Network', 'Security', 'Hardware'])
  end

  it "can initialize with a string" do
    str = "S|N|100\nN|P|200\nN|M|20\nP|M|15"
    graph = DataStructure::UndirectedGraph.new(str)

    graph.adjacencies_of('S').to_set.should == Set.new(['N'])
    graph.find_vertex('S').weight_with('N').should == 100
  end

  it "should access all vertexes" do
    @graph.vertexes.should == @vertex_set
  end

  it "can get adjacencies of a vertex" do
    @graph.adjacencies_of('Mobile').to_set.should == Set.new(['E-Commerce', 'Social Network'])
    @graph.adjacencies_of('Hardware').to_set.should == Set.new(['Security', 'Social Network', 'E-Commerce'])
  end

  it "can get weight between two vertexes" do
    @graph.find_vertex('Hardware').weight_with('Social Network').should == 10
    @graph.find_vertex('Mobile').weight_with('Social Network').should == 150
    @graph.find_vertex('Mobile').weight_with('Security').should == INFINITY
  end

  it "can depth first traverse all vertexes" do
    set = Set.new
    @graph.depth_first_traverse_from('Mobile') do |vertex|
      set.add vertex
    end

    set.should == @vertex_set
  end

  it "can breadth first traverse all vertexes" do
    set = Set.new
    @graph.breadth_first_traverse_from('Mobile') do |vertex|
      set.add vertex
    end

    set.should == @vertex_set
  end

  it "can generate minimum spanning tree with prim" do
    graph = @graph.prim_minimum_spanning_tree

    graph.adjacencies_of('Mobile').to_set.should == Set.new(['Social Network'])
    graph.find_vertex('Mobile').weight_with('Social Network').should == 150
    graph.find_vertex('Mobile').weight_with('E-Commerce').should == INFINITY

    graph.adjacencies_of('Social Network').to_set.should == Set.new(['Security', 'Hardware', 'Mobile'])
    graph.find_vertex('Social Network').weight_with('Security').should == 35
    graph.find_vertex('Social Network').weight_with('Hardware').should == 10
    graph.find_vertex('Social Network').weight_with('E-Commerce').should == INFINITY

    graph.adjacencies_of('Security').to_set.should == Set.new(['E-Commerce', 'Social Network'])
    graph.find_vertex('Security').weight_with('E-Commerce').should == 20
    graph.find_vertex('Security').weight_with('Hardware').should == INFINITY

    graph.adjacencies_of('E-Commerce').to_set.should == Set.new(['Security'])
    graph.adjacencies_of('Hardware').to_set.should == Set.new(['Social Network'])
  end

end

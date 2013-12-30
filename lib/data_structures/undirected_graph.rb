module DataStructure
  class UndirectedGraph

    SourceType = %W(files)

    def initialize(source)
      # the vertex objects array
      @vertexes = Array.new
      # the vertex data and index hash
      @vertex_table = Hash.new

      if source.is_a?(File)
        file = File.open(source)
        file.each_line do |line|
          elements = line.strip.split('|')

          v0 = add_vertex(elements[0])
          v1 = add_vertex(elements[1])
          weight = elements[2].to_i

          add_edge(v0, v1, weight)
          add_edge(v1, v0, weight)
        end
      else
        raise Exception, "graph source should be #{SourceType.join(', ')}."
      end
    end

    def include?(element)
      @vertex_set.include?(element)
    end

    def find_vertex(data_key)
      @vertexes[@vertex_table[data_key]]
    end

    def add_vertex(element)
      unless @vertex_table[element]
        v = Vertex.new(element, nil)
        @vertexes.push(v)
        @vertex_table[element] = @vertexes.size - 1
        v
      else
        v = find_vertex(element)
      end
      v
    end

    def add_edge(vertex1, vertex2, weight)
      edge = Edge.new(vertex2, nil, weight)
      if vertex1.first_edge
        next_edge = vertex1.first_edge
        return nil if next_edge.adjvex == vertex2
        while next_edge.next
          next_edge = next_edge.next
          return nil if next_edge.adjvex == vertex2
        end
        next_edge.next = edge
      else
        vertex1.first_edge = edge
      end
      edge
    end

    def index_of(v)
      @vertex_table[v.data]
    end

    def adjacencies_of(v)
      v = find_vertex(v)
      indexes = []
      if next_edge = v.first_edge
        indexes.push(index_of(next_edge.adjvex))
        while next_edge.next
          next_edge = next_edge.next
          indexes.push(index_of(next_edge.adjvex))
        end
      end
      indexes.map{ |i| @vertexes[i].data }
    end

    def vertexes
      Set.new @vertex_table.keys
    end

    class Vertex
      attr_accessor :data, :first_edge

      def initialize(data, first_edge = nil)
        @data = data
        @first_edge = first_edge
      end

      def weight_with(target)
        next_edge = first_edge
        if next_edge
          if next_edge.adjvex.data_equal_with(target)
            return next_edge.weight
          else
            while next_edge.next
              if next_edge.next.adjvex.data_equal_with(target)
                return next_edge.next.weight
              end
            end
          end
        end

        raise Exception, "There is not edge between #{data} and #{target_vertex.data}."
      end

      def data_equal_with(target)
        data == target
      end
    end

    Edge = Struct.new(:adjvex, :next, :weight)
  end
end

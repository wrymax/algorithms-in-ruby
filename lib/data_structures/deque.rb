module DataStructure
  # the node element
  Node = Struct.new(:left, :right, :object)

  class Deque
    attr_reader :size

    def initialize(ary = [])
      @size = 0
      @front = nil
      @back = nil
      ary.to_a.each do |elem|
        push_back elem
      end
    end

    def back
      @back && @back.object
    end

    def front
      @front && @front.object
    end

    def push_back(elem)
      node = Node.new(nil, nil, elem)
      if @back
        @back.right = node
        node.left = @back
        @back = node
      else
        @back = @front = node
      end
      @size += 1
    end

    def push_front(elem)
      node = Node.new(nil, nil, elem)
      if @front
        @front.left = node
        node.right = @front
        @front = node
      else
        @back = @front = node
      end
      @size += 1
    end

    def pop_back
      node = @back
      if node
        @back.left.right = nil
        @back = @back.left
        node.left = nil
        @size -= 1
        node.object
      else
        nil
      end
    end

    def pop_front
      node = @front
      if node
        @front.right.left = nil
        @front = @front.right
        node.right = nil
        @size -= 1
        node.object
      else
        nil
      end
    end

    def each_forward
      if @front
        node = @front
        while node
          yield node.object
          node = node.right
        end
      else
        nil
      end
    end

    def each_backward
      if @back
        node = @back
        while node
          yield node.object
          node = node.left
        end
      else
        nil
      end
    end

    def empty?
      @size == 0
    end
  end
end

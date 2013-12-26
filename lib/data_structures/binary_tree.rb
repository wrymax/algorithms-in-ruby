require 'data_structures/deque'

module DataStructure
	class BinaryTree
		attr_reader :size

		def initialize(data = [])
			@size = 0
			@root = Node.new(nil)
			make_tree(self, data, 1)
			@size = data.size
		end

		def root
			@root.data
		end

		def left_child
			@root
		end

		def left_child=(node)
			@root = node
		end

		# use complete binary tree and pre order to generate a tree
		def make_tree(node, arr, index, child_pos = 'left_child')
			if index > arr.size
				return nil
			else
				new_node = Node.new(arr[index - 1])
			  n = node.send("#{child_pos}=", new_node)
				@root = n if index == 1

				make_tree(n, arr, index*2, 'left_child')
				make_tree(n, arr, index*2 + 1, 'right_child')
			end
			self
		end

		def push(elem)
			node = Node.new(elem)
			if @root.data.nil?
				@root = node
				@size += 1
			else
				deque = [@root]
				while !deque.empty?
					# n = deque.pop_front
					n = deque.shift
					if n.left_child.nil?
						n.left_child = node
						@size += 1
						break
					elsif n.right_child.nil?
						n.right_child = node
						@size += 1
						break
					else
						deque.push(n.left_child)
						deque.push(n.right_child)
					end
				end
			end
			@size
		end

		def pre_order_traverse(node = @root, &block)
			if node.nil?
				return nil
			else
				yield node.data if block_given?
				pre_order_traverse(node.left_child, &block)
				pre_order_traverse(node.right_child, &block)
			end
		end

		def in_order_traverse(node = @root, &block)
			if node.nil?
				return nil
			else
				in_order_traverse(node.left_child, &block)
				yield node.data if block_given?
				in_order_traverse(node.right_child, &block)
			end
		end

		def post_order_traverse(node = @root, &block)
			if node.nil?
				return nil
			else
				post_order_traverse(node.left_child, &block)
				post_order_traverse(node.right_child, &block)
				yield node.data if block_given?
			end
		end

		def level_order_traverse(&block)
			if @root.data.nil?
				nil
			else
				# TODO: use my own deque and debug it
				# deque = Deque.new
				# ap @root
				# deque.push_back(@root)

				deque = [@root]
				while !deque.empty?
					# n = deque.pop_front
					n = deque.shift
					yield n.data if block_given?
					deque.push(n.left_child) if n.left_child
					deque.push(n.right_child) if n.right_child
				end
			end
		end

		class Node
			attr_accessor :left_child, :right_child, :data

			def initialize(data)
				@data = data
				@left_child = @right_child = nil
			end
		end

	end
end

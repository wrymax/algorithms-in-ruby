module DataStructure
	class Heap
		attr_accessor :size

		class Node
			attr_accessor :obj

			def initialize(elem)
				@obj = elem
			end

		end

		class Position
			def initialize(pos)
				@pos = pos
			end

			def left
				@pos * 2
			end

			def right
				@pos * 2 + 1
			end
		end

		def initialize(ary = [])
			@container = ([nil] + ary).map{ |n| Node.new(n) }
			@size = @container.size - 1
			heapify
		end

		def push(elem)
			@container << Node.new(elem)
			@size += 1
			heapify
		end

		def [](pos)
			@container[pos].obj
		end

		def sort
			result = []
			(@size - 1).downto(0) do |i|
				@container[i + 1], @container[1] = @container[1], @container[i + 1]
				result.push pop
				heapify
			end
			result
		end

		def pop
			if @size > 0
				@size -= 1
				@container.pop.obj
			else
				nil
			end
		end

		def root
			if @size > 0
				self[1]
			else
				nil
			end
		end

		def last
			if @size > 0
				self[@size]
			else
				nil
			end
		end

		private

		def heapify
			if @size > 1
				(@size / 2).downto(1) do |pos|
					adjust(pos)
				end
			end
			self
		end

		# adjust does this:
		# check the root node with it left and right node;
		# exchange the bigger one with root node;
		# if exchange happens, recursively adjust with the new root, which is exchanged with the old root node
		def adjust(root_pos, target_pos = @size)
			raise Exception, 'target_pos should not be larger than @size' if target_pos > @size

			# binding.pry
			left = Position.new(root_pos).left
			right = Position.new(root_pos).right
			max = root_pos

			# compare with left
			if left <= target_pos && node_at(left).obj > node_at(max).obj
				max = left
			end

			# compare with right
			if right <= target_pos && node_at(right).obj > node_at(max).obj
				max = right
			end

			# here max is the position of the max of root, left and right
			if max != root_pos
				@container[max], @container[root_pos] = @container[root_pos], @container[max]
				adjust(max)
			else
				self
			end
		end

		def node_at(pos)
			@container[pos]
		end

	end
end

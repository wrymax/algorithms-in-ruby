require 'data_structures/deque'

module DataStructure
	class Stack
		def initialize(ary = [])
			@container = Deque.new(ary)
		end

		def pop
			@container.pop_back
		end

		def next
			@container.back
		end

		def push(element)
			@container.push_back element
			@container.size
		end

		def size
			@container.size
		end

		def empty?
			@container.size.zero?
		end

		def each(&block)
			@container.each_backward(&block)
		end
	end
end

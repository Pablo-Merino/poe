module Poe

	class Position
		attr_accessor :position
		def initialize(line,column)
			@position = [line, column]
		end

		def inspect
			"[#{@position.first}, #{@position.last}]"
		end

	end

end
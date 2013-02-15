module Poe
	class Editor
		A_TO_Z_a_TO_z_0_TO_9 = ('a'..'z').to_a + ("A".."Z").to_a + ("0".."9").to_a

		def is_letter?(c)
			A_TO_Z_a_TO_z_0_TO_9.include?(c)
		end
		attr_accessor :text_cache
		def initialize(screen, path)
			@text_cache = Poe::TextCache.new(path)
			@screen = screen
			@text_cache.text.each_with_index do |line, index|
				@screen.write(index + 1, 0, "#{line}")
			end

		end
		def self.load(screen, path)
			self.new(screen, path)

		end

		def redraw(screen)
			@text_cache.text.each_with_index do |line, index|
				screen.write(index, 0, "#{line}")
			end
		end

		def handle_key(key)
			case key
			when :up
				unless @screen.position.position[0] <= 1
					@screen.set_cursor(@screen.position.position[0] - 1, @screen.position.position[1])
				end


			when :down
				unless @screen.position.position[0] >= @text_cache.lines
					@screen.set_cursor(@screen.position.position[0] + 1, @screen.position.position[1])
				end
			when :left
				unless @screen.position.position[1] <= 0
					@screen.set_cursor(@screen.position.position[0], @screen.position.position[1] - 1)
				end
			when :right
				unless @screen.position.position[1] >= @screen.columns
					@screen.set_cursor(@screen.position.position[0], @screen.position.position[1] + 1)
				end
				
			when :backspace
				unless @screen.position.position[1] <= 0
					@screen.backspace_char
					@text_cache.remove_at(@screen.position.position[1], @screen.position.position[0])
				end
			when :delete
				unless @screen.position.position[1] < 0
					@screen.delete_char
					@text_cache.remove_at(@screen.position.position[1], @screen.position.position[0])
				end
			when :enter
				if @screen.position.position[1] > 0
					@screen.insert_char("\n")
					@screen.set_cursor(@screen.position.position[0] + 1, 0)
					@text_cache.lines = @text_cache.lines + 1
					@text_cache.insert_at(@screen.position.position[1], @screen.position.position[0], "\n")
				else
					Curses.insertln
					@text_cache.insert_at(0, @screen.position.position[0], "\n")
				end

			when :tab
				@screen.insert_char(" "*2)
				@text_cache.insert_at(@screen.position.position[1], @screen.position.position[0], " "*2)
			else
				@screen.insert_char(key.to_s)
				@text_cache.insert_at(@screen.position.position[1], @screen.position.position[0], key.to_s)
			end
			@screen.dbg_write(@screen.position.inspect)
		end
	end
end

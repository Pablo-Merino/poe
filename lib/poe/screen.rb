module Poe
	class Screen
		attr_reader :position
		def self.open(&block)
			new.open(&block)
		end

		def open(&block)
			@position = Position.new(1, 0)
			Curses.noecho # do not show typed chars
			Curses.nonl # turn off newline translation
			Curses.stdscr.keypad(true) # enable arrow keys
			Curses.raw # give us all other keys
			Curses.stdscr.nodelay = 1 # do not block -> we can use timeouts
			Curses.init_screen
			Curses.start_color if Curses.has_colors?
			yield self
		ensure
			Curses.clear # needed to clear the menu/status bar on windows
			Curses.close_screen
		end
		def write(line,row,text)
			Curses.setpos(line,row)
			Curses.addstr(text)
		end

		def dbg_write(text)
			Curses.setpos(lines - 1, 0)
			Curses.addstr(text)
			Curses.setpos(@position.position.first,@position.position.last)
		end
		def columns
			Curses.stdscr.maxx
		end

		def lines
			Curses.stdscr.maxy
		end

		def set_cursor(line, row)
			@position = Position.new(line, row)

			Curses.setpos(line,row)

		end

		def clear
			Curses.clear
		end

		def backspace_char

			@position = Position.new(@position.position[0], @position.position[1] - 1)
			dbg_write(@position.inspect)
			Curses.setpos(@position.position[0], @position.position[1])
			Curses.delch

		end
		def delete_char

			Curses.delch
			Curses.setpos(@position.position[0], @position.position[1])
			dbg_write(@position.inspect)

		end

		def insert_char(ch)
			text = ch.force_encoding('UTF-8')

			unless @position.position[1] < 0
				text.split('').each do |c|
					Curses.insch(c)
				end
				@position = Position.new(@position.position[0], @position.position[1] + text.length)
				Curses.setpos(@position.position[0], @position.position[1])
				dbg_write(@position.inspect)
			end

		end
	end
end

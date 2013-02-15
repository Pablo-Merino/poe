module Poe

	class StatusBar
		def initialize(screen, text)
			@screen = screen
			@orig_text = text
			@text = "#{@orig_text} (#{@screen.lines} lines :: #{@screen.columns} columns)"
			fill_line = @screen.columns - @text.length
			Curses.attron(Curses::A_REVERSE)
			@screen.write(0,0,"#{@text}#{" "*fill_line}")
			Curses.attroff(Curses::A_REVERSE)
			Curses.setpos(1,0)
		end

		def redraw(screen)
			@screen = screen
			@text = "#{@orig_text} (#{@screen.lines} lines :: #{@screen.columns} columns)"
			fill_line = @screen.columns - @text.length
			Curses.attron(Curses::A_REVERSE)
			@screen.write(0,0,"#{@text}#{" "*fill_line}")
			Curses.attroff(Curses::A_REVERSE)
			Curses.setpos(1,0)
		end
	end

end
module Poe

	class KeyboardHandler

		def self.output(&block)
			loop do
				key = Curses.getch
				unless key.nil?
					case key

					when Curses::Key::UP then yield :key_up
					when Curses::Key::DOWN then yield :key_down
					when Curses::Key::LEFT then yield :key_left
					when Curses::Key::RIGHT then yield :key_right
					
					when Curses::Key::BACKSPACE, 127, 263 then yield :backspace
					when 13 then yield :return
					

					when 3 then yield :ctrl_c
					when Curses::KEY_RESIZE, 410 then yield :resize

					else
						yield key
					end
				end
			end
		end

		
	end

end

module Poe

	class TextCache
		attr_accessor :text
		attr_reader :text_str
		attr_accessor :lines
		attr_reader :filename
		attr_accessor :full_filename

		def initialize(file)
			@filename = File.basename(file)
			@full_filename = File.expand_path(file)
			if File.exist?(File.expand_path(file))
				@text = File.open(File.expand_path(file)).read.split("\n")
				if @text.empty?
					@text = [""]
				end
				@text_str = File.open(File.expand_path(file)).read
				@lines = @text.length
			else
				@text = [""]
				@text_str = ""
				@lines = 1
			end

		end

		def insert_at(row, line, text)
			if text == "\n" and row == 0
				@text.unshift("\n")
				File.open("./debug", "w+") do |f|
					f.write("#{row}, #{line}, #{text.inspect}, #{@text.uniq.join}")
				end
			else
				@text[line] = @text[line - 1].insert(row - text.length, text)
			end
			@text_str = @text.uniq.join

		end

		def remove_at(row, line)
			unless @text[line - 1].nil?
				new_line = @text[line - 1]
				new_line.slice!(row)
				@text[line - 1] = new_line
			end
			@text_str = @text.uniq.join
		end

		def save

			File.open(@full_filename, "w+") do |f|
				f.write(@text_str)
			end
			exit
		end
	end

end

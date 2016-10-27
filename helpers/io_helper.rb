require 'erb'

module IO_helper
	def run_cmd(path)
		FileUtils.cd(path) do
			yield
		end
	end

	def mkdir(dest)
		if(File.directory?(dest))
			puts "#{dest} already exist!"
			return 0
		end
		FileUtils.mkdir(dest)
	end

	def copy(src, dest)
		FileUtils.cp(src, dest)
	end

	def copy_dir(src, dest)
		FileUtils.copy_entry(src, dest)
	end

	def template(src, dest, replace=false)
		if(File.file?(dest) and !replace)
			puts "#{dest} already exist!"
			return 0
		end
		template = File.open(src, 'r')
		file_contents = template.read
		template.close
		renderer = ERB.new(file_contents)
		result = renderer.result(binding)
		output = File.open(dest, 'w+')
		output.write(result)
		output.close
	end

	def rm_file(path)
		FileUtils.remove_file path
	end

	def rm_dir(path)
		FileUtils.rmdir path 
	end

	def in_file?(string, path)
		regexp, content = Regexp.new string
		File.open(path, 'r'){|f| content = f.read }
		content =~ regexp
	end

	def write_start(string, path)
		lines = []
		File.open(path, 'r'){|f| lines = f.readlines }
		lines.unshift("#{string}\n")
		File.open(path, 'w+'){|f| f.write(lines.join)}
	end
	
	def write_end(string, path)
		lines = []
		File.open(path, 'r'){|f| lines = f.readlines }
		lines << "#{string}\n"
		File.open(path, 'w+'){|f| f.write(lines.join)}
	end

	def write_after(id, string, path)
		lines = []
		File.open(path, 'r'){|f| lines = f.readlines }
		new_lines = lines.inject([]) do |result, value|
			if value.include? id
				result << value
				result << "#{string}\n"
			else
				result << value
			end
		end
		File.open(path, 'w+'){|f| f.write(new_lines.join)}
	end

	def rm_string(string, path)
		regexp = Regexp.new string
		lines = []
		File.open(path, 'r'){|f| lines = f.readlines }
		new_lines = lines.reject{|line| line =~ regexp }
		File.open(path, 'w+'){|f| f.write(new_lines.join)}
	end

	def rm_block(start_id, end_id, path)
		start_regexp = Regexp.new start_id
		end_regexp = Regexp.new end_id
		lines, new_lines, result = [], [], true
		File.open(path, 'r'){|f| lines = f.readlines }
		lines.chunk { |line|
			if line =~ start_regexp
				result = false
			elsif line =~ end_regexp
				result = true
			end
			result
		}.each{ |result, arr| 
			if result
				arr[0] =~ end_regexp ? arr.shift : arr
				new_lines << arr
			end
		}
		File.open(path, 'w+'){|f| f.write(new_lines.join)}
	end

	def cli_exist?(path, cli)
		File.directory?("#{path}/#{cli}")
	end

	def command_exist?(path, command)
		File.file?("#{path}/subcommands/#{command}.rb")
	end

	def subcommand_exist?(path, command, subcommand)
		File.file?("#{path}/subcommands/#{command}/#{command}_#{subcommand}.rb")
	end

	def have_subcommands?(path, cli, command)
		in_file? /register/, 
			"#{path}/#{cli}/subcommands/#{command}.rb"	
	end
end

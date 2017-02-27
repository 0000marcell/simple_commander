require 'colorize'
require 'erb'

#functions
# run_cmd
# run_in
# mk_dir
# copy
# copy_dir
# template
# rm_file
# rm_dir
# in_file?
# in_file_snippet?
# write_start
# write_end
# write_after
# write_in
# find_file
# rm_string
# rm_block 
# cd_in
# cli_exist?
# command_exist?
# subcommand_exist?
# have_subcommands?

module IO_helper
  def run_cmd(command)
    puts "running command: #{command}".colorize(:light_green)  
    puts `#{command}`
  end

	def run_in(path)
		FileUtils.cd(path) do
			yield
		end
	end

	def mkdir(dest)
		if(File.directory?(dest))
			puts "mkdir ERROR: #{dest} already exist!".colorize(:red)
			return 0
		end
    puts "Creating folder #{dest}".colorize(:blue)
		FileUtils.mkdir(dest)
	end

	def copy(src, dest)
    puts "Copying from #{src} to #{dest}".colorize(:green)
		FileUtils.cp(src, dest)
	end

	def copy_dir(src, dest)
    puts "Copying from #{src} to #{dest}".colorize(:green)
		FileUtils.copy_entry(src, dest)
	end

	def template(src, dest, context, replace=true)
		if(File.file?(dest) and !replace)
			puts "template ERROR: #{dest} already exist!".colorize(:red)
			return 0
		end
    puts "template from #{src} to #{dest} replace: #{replace}".colorize(:magenta)
		template = File.open(src, 'r')
		file_contents = template.read
		template.close
		renderer = ERB.new(file_contents)
		result = renderer.result(context)
		output = File.open(dest, 'w+')
		output.write(result)
		output.close
	end

	def rm_file(path)
    puts "rm file #{path}".colorize(:light_red)
    if File.file? path
		  FileUtils.remove_file path
    else
      puts "File #{path} does not exit!".colorize(:light_red)
    end
	end

	# remove folder recursively 
	def rm_dir(path)
    puts "rm dir #{path}".colorize(:light_red)
		FileUtils.rm_rf path 
	end

	def in_file?(string, path)
    puts "checking if #{string} is in #{path}".colorize(:magenta)
		regexp, content = Regexp.new(Regexp.escape(string))
		File.open(path, 'r'){|f| content = f.read }
    content =~ regexp ? true : false
	end

  def in_file_snippet?(id_start, id_end, string, path)
    msg = <<~HEREDOC
      checking if the string #{string} is between #{id_start}  
      and #{id_end} in the file #{path}
    HEREDOC
    puts msg.colorize(:magenta)
    regexp, content = Regexp.new(Regexp.escape(string))
    File.open(path, 'r'){|f| content = f.read }
    content = content.split(id_start)[1]
    content = content.split(id_end)[0]
    content =~ regexp ? true : false
  end

	def write_start(string, path)
    puts "Trying to write at the start #{string[0...8]} ... on the file #{path}".colorize(:magenta)
		lines = []
		File.open(path, 'r'){|f| lines = f.readlines }
		lines.unshift("#{string}\n")
		File.open(path, 'w+'){|f| f.write(lines.join)}
	end
	
	def write_end(string, path)
    puts "Trying to write at the end #{string[0...8]} ... on the file #{path}".colorize(:magenta)
		lines = []
		File.open(path, 'r'){|f| lines = f.readlines }
		lines << "#{string}\n"
		File.open(path, 'w+'){|f| f.write(lines.join)}
	end

	def write_after(id, string, path)
    puts "Trying to write after #{id} the string #{string[0...8]} ... on the file #{path}".colorize(:magenta)
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

  # the 2 ids the second one is just a safe item
  # the string will be inserted after the first one
  def write_in(ids, string, path, dup = false)
    puts "Trying to write in line after #{ids} the string #{string[0...8]} ... on the file #{path}".colorize(:magenta)
    lines = []
    File.open(path, 'r'){|f| lines = f.readlines }
    regexps = []
    ids.each { |id| regexps << Regexp.new(id) }
    inserted_line = false
    new_lines = lines.inject([]) do |result, value|
      if value =~ regexps[0] and value =~ regexps[1]
        insert = true
        if !dup
          insert = value =~ Regexp.new(string) ? false : true
        end
        if insert
          inserted_line = true
          index = value =~ regexps[0]
          value.insert(index + ids[0].length, 
                     string)
        else
          puts "The string to be inserted was already in the line".colorize(:red)
        end
      end
      result << value
    end
    if !inserted_line
      puts "No new line was inserted".colorize(:red) 
    else
      File.open(path, 'w+'){|f| f.write(new_lines.join)}
    end
  end

  # tries to find a file with a part of the name
  def find_file(file_name, dir)
    Dir.foreach(dir) do |item|
      next if item == '.' or item == '..'
      regexp = Regexp.new(Regexp.escape(file_name))
      if item =~ regexp
        return item
      end
    end
    return false
  end

	def rm_string(string, path)
    puts "Removing #{string[0...8]} from #{path}".colorize(:light_red)
		regexp = Regexp.new(Regexp.escape(string))
		lines = []
		File.open(path, 'r'){|f| lines = f.readlines }
		new_lines = lines.reject{|line| line =~ regexp }
		File.open(path, 'w+'){|f| f.write(new_lines.join)}
	end
  
  # the ids are escaped
	def rm_block(start_id, end_id, path)
    puts "Removing string block from #{start_id} to #{end_id} #{path}".colorize(:light_red)
		start_regexp = Regexp.new(Regexp.escape(start_id))
		end_regexp = Regexp.new(Regexp.escape(end_id))
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

  def cd_in(path) 
    puts "cd into #{path}".colorize(:green)
    FileUtils.cd(path)
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

require 'byebug'
require 'fileutils'

FileUtils.rm('Manifest')

def glob(path)
  return if !File.directory?(path) && path != '**'
  path = "#{path}/*"
  Dir.glob(path) do |file|
    File.open('Manifest', 'a') { |f| f.write("#{file}\n") }
    glob(file)
  end
end

glob('**')

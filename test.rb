module Helper
	def testing 
		puts 'testing!'
	end
end


class Document
	def include_mixin
		Document.include Helper
	end
end

class InvalidCommandError < StandardError; end
Helper123 = "marcell"
#puts Object.const_get("Helper").instance_of?(::Module)
#fail InvalidCommandError, 'invalid command', caller if !defined? helper_name

doc = Document.new
doc.include_mixin
doc.testing

puts doc.methods.include? :testing


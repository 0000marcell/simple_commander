class SDocument
	def inside
		puts 'inside'
	end
end


class Document
	def initialize
		SDocument.new.tap do |obj|
			obj.inside
			outside
		end
	end
	
	def outside
		puts 'outside'
	end
end

obj = Document.new




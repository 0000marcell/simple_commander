module Commander
	class CLI
		attr_accessor :path
		class Fuck < StandardError
			def initialize
				super("this is a error")
			end
		end

		def initialize
			@path = 'marcell'
		end

		def self.error
			raise Fuck
		end
	end
end

cli = Commander::CLI.new
cli.path = 'joao'
puts cli.path

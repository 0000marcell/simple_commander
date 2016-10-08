module Commander
	module CLI
		class Fuck < StandardError
			def initialize
				super("this is a error")
			end
		end

		def self.error
			raise Fuck
		end
	end
end

Commander::CLI.error

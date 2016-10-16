class Test
	attr_accessor :summary

	def summary(val)
		@summary = val
	end
end

test = Test.new
test.summary 'marcell'
puts test.instance_variable_get(:@summary)

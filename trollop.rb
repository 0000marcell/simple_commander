require 'trollop'
opts = Trollop::options do
	opt :monkey, "Use monkey mode"
	opt :name, "Monkey name", :type => :string
	opt :num_limbs, "Number of limbs", :default => 4
end	

p opts

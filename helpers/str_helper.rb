require 'colorize'

module STR_helper
  def camelize(string, type = 'lower')
    puts "#{type} camilize the string #{string}".colorize(:magenta)
    if type == 'lower'
      return string.split('-')[0] + 
       string.split('-')[1].capitalize
    else
      return string.capitalize
    end
  end
end

require_relative 'constants'

#module for human input of a code
module Human

  def ask_for_input(input)
    #makes input blank array
    input = []
    i = 1
    #repeats until 4 correct codes are input
    loop do
      #puts message asking for guess 1,2,3,4
      print "Enter color code ##{i}: "
      #gets guess and pushes to guess array
      entry = gets.chomp.downcase
      #check for valid guess
      if valid_code?(entry)
        input.push(entry)
        i += 1
      else
        puts "not a valid color code. Try again."
      end
      break if i > 4
    end
    input
  end

  #check if valid color code
  def valid_code?(code)
    COLOR_CHOICES.any? { |k, v| k.to_s == code}
  end
end
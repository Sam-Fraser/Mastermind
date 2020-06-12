require_relative 'constants'

#gameboard class
class GameBoard
  attr_reader :num_of_guesses, :master_code, :guesses

  #initialize with
  def initialize
    #new gameboard
    @guesses = Array.new(12, Array.new(6, '--'))
    #number of guesses
    @num_of_guesses = 0
    #master code
    @master_code = []
  end

  #save code method
  def save_code(code)
    @master_code = code
  end

  #save guess method
  def save_guess(guess)
    @guesses[@num_of_guesses] = guess
  end

  #increment guess count method
  def count_guess
    @num_of_guesses += 1
  end

  #saves number of correct colors and number of correct positions
  def save_correct_answers(correct_color, correct_position)
    @guesses[@num_of_guesses].push([correct_color, correct_position]).flatten!
  end

  #checks for right color
  def num_with_correct_color(code, guess)
    intersection = (code & guess).flat_map { |n| [n]*[code.count(n), guess.count(n)].min }
    #returns number of colors from guess that coincide with colors from code
    intersection.length
  end

  #checks for right position
  def num_in_correct_position(code, guess)
    #number of guesses in the correct spot
    x = 0
    #check for length of code
    4.times do |i|
      x += 1 if code[i] == guess[i]
    end
    #returns number of guesses that are in the correct spot
    x
  end

  #checks guess against code and saves to board
  def check_code(code, guess)
    #returns how many choices are right color
    correct_color = num_with_correct_color(code, guess)
    #returns how many choices are in the right place
    correct_position = num_in_correct_position(code, guess)
    correct_color -= correct_position
    #updates gameboard
    save_correct_answers(correct_color, correct_position)
  end

  #checks if correct code was input
  def correct_code?(code, guess)
    code == guess[0, 4]
  end

  #changes the color codes to names for better output at game end
  def get_color_names
    @master_code.each_with_index do |v, i|
      v = COLOR_CHOICES[v.to_sym]
      @master_code[i] = v.capitalize
    end
    @master_code.join(' ')
  end

  #display board
  def display_board
    puts "You have #{12 - @num_of_guesses} guesses left"
    puts "color codes:"
    COLOR_CHOICES.each { |k, v| print "#{k} = #{v} "}
    print "\n"
    #displays gameboard with - - - - for empty guesses
    #displays 12 lines
    #displays how many right colors/wrong spots and how many right colors/right spots on each line
    @guesses.each { |guess| puts "| #{guess[0]} #{guess[1]} #{guess[2]} #{guess[3]} | Correct Colors: #{guess[4]} | Correctly Placed Colors #{guess[5]} |" } 
  end
end
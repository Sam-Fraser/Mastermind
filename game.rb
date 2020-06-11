COLOR_CHOICES = {
  rd: 'red',
  bu: 'blue',
  yw: 'yellow',
  gn: 'green',
  bk: 'black',
  wh: 'white'
}

#game class that runs the game
class Game

  #initialize the game with
  def initialize
    #gameboard
    @board = GameBoard.new
    #codemaster
    @code_master = CodeMaster.new
    #codebreaker
    @code_breaker = CodeBreaker.new(@board)
  end

  #play method
  def play
    #calls blank gameboard
    @board.display_board
    #gets new codemaster code
    @code_master.create_code
    #loops 12 times
    12.times do
      #gets codebreaker guess
      @code_breaker.ask_for_guess
      #checks against codemaster code
      #returns how many choices are right color
      correct_color = num_with_correct_color(@code_master.code, @code_breaker.guess)
      #returns how many choices are in the right place
      correct_position = num_in_correct_position(@code_master.code, @code_breaker.guess)
      correct_color -= correct_position
      #updates gameboard
      @board.save_correct_answers(correct_color, correct_position)
      #prints gameboard
      @board.display_board
      #breaks if codebreaker guess = codemaster code
      if correct_code?(@code_master.code, @code_breaker.guess)
        puts "Congrats you win! The Code was #{@code_master.code.join(' ')}"
        break
      end
      #increments guess counter
      @board.count_guess
    end
    if @board.num_of_guesses == 12
      puts "Looks like you lost. Here was the code dummy: #{@code_master.code.join(' ')}"
    end
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

  #checks if correct code was input
  def correct_code?(code, guess)
    code == guess[0, 4]
  end

end

#codemaster class
class CodeMaster
  #constant array variable of all colors
  CHOICES = COLOR_CHOICES.keys
  #code variable is readable and writable
  attr_reader :code

  #initialize with 
  def initialize
    #code instance variable
    @code = []
  end

  #create method
  def create_code
    #chooses 4 colors at random from colors array
    4.times do
      i = rand(6)
      #save in code variable
      @code.push(CHOICES[i].to_s)
    end 
  end
end

#codebreaker class
class CodeBreaker
  #guess should be readable and writable
  attr_reader :guess

  #initialize with
  def initialize(board)
    #guess instance variable
    @guess = []
    #gameboard
    @board = board
  end

  #ask for guess method
  def ask_for_guess
    #makes guess blank array
    @guess = []
    i = 1
    #repeats until 4 correct codes are input
    loop do
      #puts message asking for guess 1,2,3,4
      print "Enter color code ##{i}: "
      #gets guess and pushes to guess array
      entry = gets.chomp.downcase
      #check for valid guess
      if valid_code?(entry)
        @guess.push(entry)
        i += 1
      else
        puts "not a valid color code. Try again."
      end
      break if i > 4
    end
    @board.save_guess(@guess)
    p @guess
  end

  #check if valid color code
  def valid_code?(code)
    COLOR_CHOICES.any? { |k, v| k.to_s == code}
  end
end

#gameboard class
class GameBoard
  attr_reader :num_of_guesses

  #initialize with
  def initialize
    #new gameboard
    @guesses = Array.new(12, Array.new(6, '--'))
    #number of guesses
    @num_of_guesses = 0
  end

  #save guess method
  def save_guess(guess)
    @guesses[@num_of_guesses] = guess
  end

  #increment guess count method
  def count_guess
    @num_of_guesses += 1
  end

  def save_correct_answers(correct_color, correct_position)
    @guesses[@num_of_guesses].push([correct_color, correct_position]).flatten!
  end

  #display board
  def display_board
    puts "You have #{12 - @num_of_guesses} guesses left"
    puts "color codes:"
    COLOR_CHOICES.each { |k, v| print "#{k} = #{v} : "}
    print "\n"
    #displays gameboard with - - - - for empty guesses
    #displays 12 lines
    #displays how many right colors/wrong spots and how many right colors/right spots on each line
    @guesses.each { |guess| puts "| #{guess[0]} #{guess[1]} #{guess[2]} #{guess[3]} | Correct Colors: #{guess[4]} : Correctly Placed Colors #{guess[5]}" }
    
  end
end

g = Game.new
g.play

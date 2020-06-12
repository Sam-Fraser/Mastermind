require_relative 'game_board'
require_relative 'code_master'
require_relative 'code_breaker'
require_relative 'constants'

#game class that runs the game
class Game

  #initialize the game with
  def initialize
    #gameboard
    @board = GameBoard.new
    #codemaster
    @code_master = CodeMaster.new(@board)
    #codebreaker
    @code_breaker = CodeBreaker.new(@board)
  end

  #play method
  def play
    loop do
      puts "Do you want to play as the code master or the code breaker?"
      print "(type 'M' for master and 'B' for breaker) "
      selection = gets.chomp.downcase
      print "\n"

      case selection
      when 'm'
        @code_master = HumanMaster.new(@board)
        @code_breaker = ComputerBreaker.new(@board)
        play_as_master
        break
      when 'b'
        @code_master = ComputerMaster.new(@board)
        @code_breaker = HumanBreaker.new(@board)
        play_as_breaker
        break
      else
        puts "That is not a valid entry. Try again."
      end
    end
  end

  #play as master method (you create code, computer guesses)
  def play_as_master
    #starts game
    generate_start
    #plays game
    play_loop
  end

  #play as breaker method (computer creates code, you guess code)
  def play_as_breaker
    #starts game
    generate_start
    #plays game
    play_loop
  end

  def generate_start
    #calls blank gameboard
    @board.display_board
    #gets new codemaster code
    @code_master.create_code
  end

  def play_loop
    #loops 12 times
    12.times do
      #gets codebreaker guess
      @code_breaker.ask_for_guess
      #checks against codemaster code
      @board.check_code(@board.master_code, @code_breaker.guess)
      #prints gameboard
      @board.display_board
      #breaks if codebreaker guess = codemaster code
      if win?
        puts "Congrats you win! The Code was #{@board.get_color_names}"
        break
      end
      #increments guess counter
      @board.count_guess
    end
    if loss?
      puts "Looks like you lost. Here was the code dummy: #{@board.get_color_names}"
    end
  end

  def loss?
    @board.num_of_guesses == 12
  end

  def win?
    @board.correct_code?(@board.master_code, @code_breaker.guess)
  end
end

g = Game.new
g.play
require_relative 'human'
require_relative 'constants'

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
end

#methods only available when the computer is the breaker
class ComputerBreaker < CodeBreaker
  attr_reader :guess

  def initialize(board)
    super
    #all possible choices
    @possible_choices = []
    generate_possible_choices
    #last guess
    @last_guess = []
    #current guess
    @current_guess = ['rd', 'rd', 'bu', 'bu']
  end

  def generate_possible_choices
    6.times do |a|
      6.times do |b|
        6.times do |c|
          6.times do |d|
            arr = [CHOICES[a].to_s, CHOICES[b].to_s, CHOICES[c].to_s, CHOICES[d].to_s]
            @possible_choices.push(arr)
          end
        end
      end
    end
  end

  def ask_for_guess
    #checks if first turn
    if @last_guess.empty?
      #save current guess as last guess
      @last_guess = @current_guess
      #makes guess equal to current guess
      @guess = @current_guess
    else
      #save cureent guess to last guess
      @last_guess = @current_guess
      #variable for current spot on board
      current_slot = @board.guesses[@board.num_of_guesses - 1]
      #remove all bad choices
      @possible_choices.delete_if do |arr|
        #returns how many choices are right color
        correct_color = @board.num_with_correct_color(arr, @current_guess)
        #returns how many choices are in the right place
        correct_position = @board.num_in_correct_position(arr, @current_guess)
        correct_color -= correct_position
        #now compare correct color and correct position numbers for arr and current guess to what you got when you guessed
        #removes all choices that don't give us the same numbers
        correct_color != current_slot[4] || correct_position != current_slot[5]
      end
      #save current guess
      @current_guess = @possible_choices[0]
      #save new current guess to guess
      @guess = @current_guess
    end
    @board.save_guess(@guess) 
  end
end

#methods only available when you're the code breaker
class HumanBreaker < CodeBreaker
  include Human
  attr_reader :guess

  def ask_for_guess
    @guess = ask_for_input(@guess)
    @board.save_guess(@guess)
  end
end
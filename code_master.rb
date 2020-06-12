require_relative 'human'
require_relative 'constants'

#codemaster class
class CodeMaster
  #code variable is readable and writable
  attr_reader :code

  #initialize with 
  def initialize(board)
    #code instance variable
    @code = []
    #game board
    @board = board
  end
end

#methods only available when the computer is the code master
class ComputerMaster < CodeMaster
  attr_reader :code

  #create method
  def create_code
    #chooses 4 colors at random from colors array
    4.times do
      i = rand(6)
      #save in code variable
      @code.push(CHOICES[i].to_s)
    end
    @board.save_code(@code) 
  end
end

#methods only available when you are the code master
class HumanMaster < CodeMaster
  include Human
  attr_reader :code

  #create method
  def create_code
    @code = ask_for_input(@code)
    @board.save_code(@code)
  end
end
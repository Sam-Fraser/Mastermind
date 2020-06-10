#game class that runs the game

  #initialize the game with
    #gameboard
    #codemaster
    #codebreaker

  #play method
    #calls blank gameboard
    #gets new codemaster code
    #create counter for number of guesses = 1
    #loops 12 times
      #gets codebreaker guess
      #checks against codemaster code
      #returns how many choices are right color
      #returns how many choices are in the right place
      #updates gameboard
      #prints gameboard
      #increments guess counter
      #breaks if codebreaker guess = codemaster code
    #if guess counter <= 12
      #print win message
    #else 
      #print loss message and codemaster code

#codemaster class
  #constant array variable of all colors
  #code variable is readable and writable

  #initialize with 
    #code instance variable

  #create method
    #chooses 4 colors at random from colors array 
    #save in code variable

#codebreaker class
  #guess should be readable and writable

  #initialize with 
    #guess instance variable
    #gameboard
    #codemaster code

  #ask for guess method
    #makes guess blank array
    #repeats 4 times
      #puts message asking for guess 1,2,3,4
      #gets guess and pushes to guess array

#gameboard class

  #initialize with
    #new gameboard
    #number of guesses

  #display board
    #displays gameboard with - - - - for empty guesses
    #displays 12 lines
    #displays how many right colors/wrong spots and how many right colors/right spots on each line




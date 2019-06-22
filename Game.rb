=begin
File name: Game.rb
Description: This class implements the basic version of the game of set.


Log:
# File created 05/21/2019 by Trevor Shirey
# File updated 05/28/2019 by Trevor Shirey (Added multiplayer option)
# Merged all version of command line game 05/31/2019 by Trevor Shirey
=end


require_relative 'Deck.rb'
require_relative 'Card.rb'
class Game
	
	attr_accessor :deck, :table, :userChoice, :score, :numPlayers, :turn, :hintSet, :hintAttributes, :endGame



	# Initializes new game
	# Created 05/20/2019 by Trevor Shirey
	# Implemented on 05/20/2019 by Trevor Shirey
	# Bug fixed on 05/21/2019 by Yi
	# Updated on 05/27/2019 by Trevor (Simplified)
	# Updated on 05/28/2019 by Zhengqi (Added endGame, MinDeduction, FREE_HINT, PlayerName attribute)
	# Updated on 05/28/2019 by Trevor (Added numPlayers and turn and changed score to an [])
	# Updated on 05/31/2019 by Trevor (Added new hint functionality to initialize and changed numPlayers parameter)
	def initialize

		@deck = Deck.new.deck
		@table = []
		@userChoice = []
		@score = []
		@hintSet = []
		@hintAttributes = []
		@turn = 1
		@endGame = false

		12.times {@table << @deck.shift} #Draw first 12 cards

		puts "Welcome to the command line version of the game of set!"
		puts "In this version, cards are represented by a list of attributes for extra difficulty."
		puts ""
		puts "How many players would like to play? (1-4 recommended)" #Asks user for number of players on startup
		@numPlayers = gets.chomp!.to_i
		@numPlayers.times {score << 0}
		puts ""

	end



	# Print table to console
	# Created 05/21/2019 by Yi
	# Modified on 05/27/2019 by Trevor (visual imporvements)
	def printTable
		puts "Card#:	Color:     Shape:     Fill:     Number:"
		puts ""
		@table.each_with_index {|card, index| print (index + 1).to_s + "	"; card.printCard; puts ""}
	end



	# If {card1, card2, card3} is a valid set return true.
	# Returns false if not a valid set or if there are duplicates.
	# Created 05/21/2019 by Yi 
	#Implemented 05/22/2019 by Pranay (untested) 
	def isSet? card1, card2, card3
		numberboolean = ((card1.number == card2.number) && (card2.number == card3.number)) || ((card1.number != card2.number) && (card1.number != card3.number) && (card2.number != card3.number))

		colorboolean = ((card1.color == card2.color) && (card2.color == card3.color)) || ((card1.color != card2.color) && (card1.color != card3.color) && (card2.color != card3.color))

		shapeboolean = ((card1.shape == card2.shape) && (card2.shape == card3.shape)) || ((card1.shape != card2.shape) && (card1.shape != card3.shape) && (card2.shape != card3.shape))
		
		fillboolean = ((card1.fill == card2.fill) && (card2.fill == card3.fill)) || ((card1.fill != card2.fill) && (card1.fill != card3.fill) && (card2.fill != card3.fill))

		return (numberboolean && colorboolean && shapeboolean && fillboolean)
	end
	


	# Finds a set on the table to use for a hint
	# Created 05/21/2019 by Yi 
	# Implemented 05/22/2019 by Trevor (untested)
	# Bug fixed 05/22/2019 by Trevor (added return false)
	# Bugs fixed 05/22/2019 by Yi (arguments Card1, ..., should not be capitalized)
	# Modified 05/27/2019 by Trevor (returns a card rather than a boolean)
	# Add Specification and modify add one card to all sets on 05/28/19 by Zhengqi
	# Modified on 05/31/2019 by Trevor (changed to hintSet for new hint feature)
	#@require: table is not empty
	def findSet
		@hintSet.clear
		@table.each do |card1|
		  	(@table-[card1]).each do |card2|
		    		(@table - [card1] - [card2]).each do |card3|
		      			if isSet?(card1, card2, card3)
		        			@hintSet << card1 << card2 << card3
		      			end
		    		end
		  	end
		end

	end


	#Inplemented the body and added spcification on 5/25/2019 by Zhengqi
	#Adds 3 car to table at a time
	#@required: the number of card on the table must with in range ()
	#@update: table, deck
	#@ensure:
		#table.length += 3
	def addCards 
		for i in 1..3
			@table.push @deck.length > 0 ? @deck.shift  : nil
		end
	end



	#remove 3 card at a time by giving the index number of from table you want to remove
	#Created on 5/24/2019 by Hannah
	# Inplemented the body and added specification on 5/25 by Zhengqi
	# Implemented on 05/27/2019 by Trevor
	# Fixed bug on 05/27/2019 by Trevor
	#@require: @userChoice is an array, and userChoice[i] is in [0,11] where i is in [0,2]
	#@update: @table, @userChoice
	#@ensure: @table.length -= 3
	#@restore: @userChoice
	def removeCards
		@userChoice.each do |tableIndex|
			@table[tableIndex - 1] = nil
		end
		@table.compact!
	end


	# Created on 05/31/2019 by Pranay
	# Implemented 05/31/2019 by Pranay
	def getAttributeHint 
		card1 = @hintSet[0]
		card2 = @hintSet[1]
		card3 = @hintSet[2]
		colorSame = 0
 		numberSame = 0
		shapeSame = 0
		fillSame = 0
		@hintAttributes = [false,false,false,false]
		count = 0
		if (card1.color == card2.color && card2.color == card3.color)  
			colorSame = 1
			@hintAttributes[0] = true
		end
		if (card1.number == card2.number && card2.number == card3.number) 
			numberSame = 1
			@hintAttributes[1] = true
		end
		if (card1.shape == card2.shape && card2.shape == card3.shape) 
			shapeSame = 1
			@hintAttributes[2] = true
		end
		if (card1.fill == card2.fill && card2. fill == card3.fill) 
			fillSame = 1
			@hintAttributes[3] = true
		end		
	end



	#Created and implemented on 05/31/2019 by Trevor
	def printHint
		if @hintAttributes[0]
			puts "All three cards in the set have the same color"
			puts ""
		end
		if @hintAttributes[1]
			puts "All three cards in the set have the same number"
			puts ""
		end
		if @hintAttributes[2]
			puts "All three cards in the set have the same shape"
			puts ""
		end
		if @hintAttributes[3]
			puts "All three cards in the set have the same fill"
			puts ""
		end
		if !@hintAttributes[0] && !@hintAttributes[1] && !@hintAttributes[2] && !@hintAttributes[3]
			puts "The three cards in the set have no similar attributes"
			puts ""
		end
	end


	# Implemented on 05/23/2019 by Hannah
	# Modified on 05/25/2019 by Hannah
	# Modified on 05/27/2019 by Yi
	# Modified on 05/27/2019 by Trevor
	# Modified on 05/27/2019 by Zhengqi
	# Modified on 05/27/2019 by Pranay
	# Modified on 05/27/2019 by Hannah
	# Modified on 05/28/2019 by Trevor (Added new lines for easier viewing)
	# Allow user to end the game at any selection step on 05/28/2019 by Zhengqi
	# rewrite the method, and make sure alawys return valid selection on 05/28/2019 by Zhengqi
	# user will enter 3 card number at a time, and they do allow to have 3 free hint, beyond that, user's score will be deducted with more hint given, until no set left
	#@return: choice, which must be valid, within [1, @table.length]
	def getUserInput
		@userChoice.clear
		hintsGiven = 0
		while @userChoice.length < 3 && !@endGame
			puts "Enter a card number between 1 and " + @table.length.to_s + ". (Enter 0 for a hint) or (q to quit):"
			puts ""
			print "Player " + @turn.to_s + ": "
			choice = gets.chomp!
			if (1..@table.length) === choice.to_i and !@userChoice.include?(choice.to_i) 	#user entered a valid card
				@userChoice.push(choice.to_i)
			else
				if choice == "0" 			#user entered 0 for a hint
					if hintsGiven == 0		
						puts "There is a set on the table containing the card:"
						puts ""
						print "	  "
						@hintSet[0].printCard
						puts ""
						printHint
						hintsGiven = 1
					elsif hintsGiven == 1
						puts "Another card in the set is: "
						puts ""
						print "	  "
						@hintSet[1].printCard
						puts ""
						hintsGiven = 2
					else
						puts "There is only 1 possible card in the whole deck that will make a set with these 2 cards:"
						puts ""
						print "	  "
						@hintSet[0].printCard
						puts ""
						print "	  "
						@hintSet[1].printCard
						puts ""
						printHint
					end						
				elsif choice == "q" || choice == "Q" 	#user entered q or Q to quit
					@endGame = true
					return
				else					#user entered invalid input
					puts "Invalid input! Please try again."
				end
			end
		end
	end


	# Created on 05/25/2019 by Trevor
	# Implemented 05/25/2019 by Trevor
	# Bug fixed 05/27/2019 by Yi (fixed hint functionality)
	# Bug fixed 05/27/2019 by Pranay (printTable parameterization)
	# Bug fixed 05/27/2019 by Hannah (fixed read only attribute bug: score functionality)
	# Bug fixed 05/27/2019 by Zhengqi (fixed addCards parameterization)
	# Modified on 05/28/2019 by Trevor (Added multiplayer functionality)
	# Bug fixed 05/27/2019 by Zhengqi (fixed game.getUserInput)
	# Rewrtite the "main" method, rebuild to case statement on 05/28/2019 by Zhengqi
	# Updated on 05/31/2019 by Trevor (Updated hint functionality and cleaned up code)
	
	#Main:

	game = Game.new
	game.findSet

	while game.hintSet.length == 0 # No set currently on the table
		game.addCards
	end

	while !game.endGame		#game runs until user quits or the game ends
		game.getAttributeHint
		puts "Cards on the table: "
		puts ""
		game.printTable
		game.getUserInput
		if !game.endGame	# Only enters branch if user did not enter q to quit
			if game.isSet? game.table[game.userChoice[0] - 1], game.table[game.userChoice[1] - 1], game.table[game.userChoice[2] - 1] # User entered a valid set
				puts "Correct! You earned 3 points for a correct set!"					
				game.score[game.turn - 1] = game.score[game.turn - 1] + 3	# 3 points for correct set
				game.removeCards
			else
				puts "Incorrect!. You lose 1 point for entering an incorrect set."
				puts ""
				if game.score[game.turn - 1] > 0
					game.score[game.turn - 1] = game.score[game.turn - 1] - 1	# 1 point deduction for incorrect set
				end
			end
			if game.table.length < 12
				game.addCards
			end
			puts "Player " + game.turn.to_s + " Score: " + game.score[game.turn - 1].to_s
			puts ""
			game.turn = game.turn + 1
			game.turn = 1 if game.turn > game.numPlayers
		end
		game.hintSet.clear
		game.findSet
		while game.hintSet.length == 0
			if deck.length > 2 
				game.addCards
			else
				game.endGame = true # Deck is empty and no more sets on the table
				puts "No more sets and deck is empty."
			end
		end
	end

	puts "Game over!"
	game.score.each_with_index {|scores, index| puts "Player " + (index + 1).to_s + " score: " + scores.to_s}

end


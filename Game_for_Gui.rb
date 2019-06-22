=begin
File name: Game_for_gui.rb
Description: This class implements the basic version of the game of set. Used for GUI.
Slightly different from Game.rb
Source code copied from Game.rb contributed by all of group, adjusted here by Yi
=end


require_relative 'Deck.rb'
require_relative 'Card.rb'
class Game
	
	attr_accessor :deck, :table, :userChoice, :score, :score_2

	# Initializes new game
	# Created 05/20/2019 by Trevor Shirey
	# Implemented on 05/20/2019 by Trevor Shirey
	# Bug fixed on 05/21/2019 by Yi
	# Updated on 05/27/2019 by Trevor
	def initialize
		
		@deck = Deck.new.deck
		@table = []
		@userChoice = []
		@score = 0
		@score_2 = 0

		#Draw first 12 cards from the deck and put them on the table
		12.times {@table << @deck.shift}

	end

	# Print table to console
	# Created 05/21/2019 by Yi
	# Modified on 05/27/2019 by Trevor (visual imporvements)
	def printTable
		@table.each_with_index {|card, index| printf("%-4i", index); card.printCard; puts ""}
	end



	# If {card1, card2, card3} is a valid set return true.
	# Returns false if not a valid set.
	# Created 05/21/2019 by Yi 
	# Implemented 05/22/2019 by Pranay (untested)
	def isSet? card1, card2, card3
	
		numberboolean = ((card1.number == card2.number) && (card2.number == card3.number)) || ((card1.number != card2.number) && (card1.number != card3.number) && (card2.number != card3.number))

		colorboolean = ((card1.color == card2.color) && (card2.color == card3.color)) || ((card1.color != card2.color) && (card1.color != card3.color) && (card2.color != card3.color))

		shapeboolean = ((card1.shape == card2.shape) && (card2.shape == card3.shape)) || ((card1.shape != card2.shape) && (card1.shape != card3.shape) && (card2.shape != card3.shape))
		
		fillboolean = ((card1.fill == card2.fill) && (card2.fill == card3.fill)) || ((card1.fill != card2.fill) && (card1.fill != card3.fill) && (card2.fill != card3.fill))

		return (numberboolean && colorboolean && shapeboolean && fillboolean)

	end
	

	# Check cards on table for a set. If a set is found, returns 1 card from that set. Otherwise returns nil.
	# Created 05/21/2019 by Yi 
	# Implemented 05/22/2019 by Trevor (untested)
	# Bug fixed 05/22/2019 by Trevor (added return false)
	# Bugs fixed 05/22/2019 by Yi (arguments Card1, ..., should not be capitalized)
	# Modified 05/27/2019 by Trevor (returns a card rather than a boolean)
	def findSet
		@table.each do |card1|
		  (@table-[card1]).each do |card2|
		    (@table - [card1] - [card2]).each do |card3|
		      if isSet?(card1, card2, card3)
				return card1, card2, card3
		      end
		    end
		  end
		end
		return nil		
	end

	# Used in shoes.rb to generate Hint
	# Copied from findSet and adjust the return statement
	def findHint
		@table.each do |card1|
			(@table-[card1]).each do |card2|
			  (@table - [card1] - [card2]).each do |card3|
				if isSet?(card1, card2, card3)
				  #return card1
				  return @table.index(card1)+1,@table.index(card2)+1,@table.index(card3)+1
				end
			  end
			end
		  end
		  return nil		
	end


	# Created on 05/31/2019 by Pranay
	# Implemented 05/31/2019 by Pranay
	def getAttributeHint hintSet
		card1 = hintSet[0]
		card2 = hintSet[1]
		card3 = hintSet[2]
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

	# Adds 3 new cards to the table
	# Implemented on 05/27/2019 by Trevor
	def addCards  
		if @deck.length > 0
			3.times {@table << @deck.shift}
		end
	end



	# Removes the 3 cards user chose from table
	# Created on 05/24/2019 by Hannah
	# Implemented on 05/27/2019 by Trevor
	def removeCards
		@userChoice.each do |card1|
			@table.each do |card2|
				if card1.path == card2.path
					@table.delete(card2)
				end
			end
			
		end
	end



	# Asks user for card number or x if they want a hint. Then returns the number or nil based on user's choice
	# Implemented on 05/23/2019 by Hannah
	# Modified on 05/25/2019 by Hannah
	# Modified on 05/27/2019 by Yi
	# Modified on 05/27/2019 by Trevor
	# Modified on 05/27/2019 by Drago
	# Modified on 05/27/2019 by Pranay
	# Modified on 05/27/2019 by Hannah

	def getUsersCardInput
		@userChoice.clear
		while @userChoice.length < 3 do
			puts "Enter a card number between 1 and " + @table.length.to_s + " or enter 0 for a hint (0 will also clear your prior choices) :"
			choice = gets.chomp!
			if (1..@table.length) === choice.to_i and !@userChoice.include?(choice.to_i)
				@userChoice.push(choice.to_i)
			else
				if choice == "0"
					findSet.printCard
				else
					puts "Invalid input! Please try again."
				end
			end
		end
		return @userChoice
	end
		

	# Created on 05/25/2019 by Trevor
	# Implemented 05/25/2019 by Trevor
	# Bug fixed 05/27/2019 by Yi (fixed hint functionality)
	# Bug fixed 05/27/2019 by Pranay (printTable parameterization)
	# Bug fixed 05/27/2019 by Hannah (fixed read only attribute bug: score functionality)
	# Bug fixed 05/27/2019 by Drago (fixed addCards parameterization)

end


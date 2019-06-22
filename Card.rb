=begin 
File name: Card.rb
Description: This class is to create card object for each card in a deck.
Each card has a unique combination of color, shape, fill and number, while index is 
used for representing this card.

Log: 
5/21: Created by Yi, Implemented by Yi
=end


class Card
	# get and set methods for members
	attr_accessor :color, :shape, :fill, :number, :path

	def initialize color, shape, fill, number, path 
		@color = color
		@shape = shape
		@fill = fill
		@number = number 
		@path = path 
	end 

	def printCard
		printf("%-10s %-10s %-10s %-10s\n", @color, @shape, @fill, @number)
	end 
end


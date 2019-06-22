=begin 
File name: Card.rb
Description: This class is to generate a deck object(represented as an array) for game "SET". 
Each deck should have 81 cards, and each cards should has a unique combination of color, shape, fill and number. 

Log: 
5/21: Created by Yi, Implemented by Yi

=end

require_relative 'Card.rb'
COLORS = [:red, :purple, :green]
FILLS = [:empty, :striped, :solid]
SHAPES = [:diamonds, :ovals, :waves]
NUMBERS = [:one, :two, :three]

class Deck

  attr_accessor :deck

  #Initializes deck with all 81 cards.
  def initialize
    @deck = []
    cardIndex = 1
    COLORS.each do |color|
      FILLS.each do |fill|
        SHAPES.each do |shape|
          NUMBERS.each do |number|
            @new_card =  Card.new(color, shape, fill, number, "./image/card#{cardIndex}.png")
            @deck << @new_card
            cardIndex += 1
          end
        end
      end
    end
    @deck.shuffle!
  end

  #if the deck is empty or not
  def is_empty
     @deck.length == 0
  end

  #Removes a random card from the deck.
  def draw_a_card
    @deck.pop
  end

  #Adds one_card from the deck.
  def push_a_card(one_card)
    @deck << one_card
  end

  
 
end



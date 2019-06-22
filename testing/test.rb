=begin
File name: test.rb
Description: Unit tests 

Log:
# File created 05/22/2019 by Yi

=end

require '../Card.rb'
require_relative '../Deck.rb'
require_relative '../Game.rb'
require 'test/unit'

class SimpleTest < Test::Unit::TestCase

    # Testing initialize in Deck.rb 
    # Created 05/22/2019 by Yi 
    def test_new_deck
        assert_equal(81, Deck.new.deck.length)
    end

    # Testing draw_a_card in Deck.rb
    # Created 05/22/2019 by Yi 
    def test_draw_a_card
        deck_object = Deck.new
        deck_object.draw_a_card
        assert_equal(80, deck_object.deck.length)
    end

     # Testing isSet? with all different categories 
   # Created 05/25/2019 by Pranay
    
   def test_isSet_all_different
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:green, :ovals, :striped,:two, 2)
	card3 = Card.new(:purple, :waves, :solid,:three, 3)
	assert_equal(true, Game.new.isSet?(card1, card2, card3))
    end
   
   # Testing isSet? with one same category
   # Created 05/25/2019 by Pranay
   def test_isSet_one_same
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:red, :ovals, :striped,:two, 2)
	card3 = Card.new(:red, :waves, :solid,:three, 3)
	assert_equal(true, Game.new.isSet?(card1, card2, card3))
    end

   # Testing isSet? with two same categories
   # Created 05/25/2019 by Pranay
    def test_isSet_two_same
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:red, :diamonds, :striped,:two, 2)
	card3 = Card.new(:red, :diamonds, :solid,:three, 3)
	assert_equal(true, Game.new.isSet?(card1, card2, card3))
    end
   
    # Testing isSet? with three same categories
    # Created 05/25/2019 by Pranay
    def test_isSet_three_same
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:red, :diamonds, :empty,:two, 2)
	card3 = Card.new(:red, :diamonds, :empty,:three, 3)
	assert_equal(true, Game.new.isSet?(card1, card2, card3))
    end
    
    # Testing isSet? with all same categories
    # Created 05/25/2019 by Pranay
    def test_isSet_four_same
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:red, :diamonds, :empty,:one, 2)
	card3 = Card.new(:red, :diamonds, :empty,:one, 3)
	assert_equal(true, Game.new.isSet?(card1, card2, card3))
    end

    # Testing isSet? with two same values(card1, card3) for color category
    # Created 05/25/2019 by Pranay
    def test_isSet_not_a_set
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:purple, :ovals, :striped,:two, 2)
	card3 = Card.new(:red, :waves, :solid,:three, 3)
	assert_equal(false, Game.new.isSet?(card1, card2, card3))
    end
     
    # Testing isSet? with two same values(card1, card2) for shape category
    # Created 05/25/2019 by Pranay
    def test_isSet_not_a_set2
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:purple, :diamonds, :striped,:two, 2)
	card3 = Card.new(:green, :ovals, :solid,:three, 3)
	assert_equal(false, Game.new.isSet?(card1, card2, card3))
    end

    # Testing isSet? with two same values(card2, card3) for fill category
    # Created 05/25/2019 by Pranay
    def test_isSet_not_a_set3
	card1 = Card.new(:red, :diamonds, :empty, :one, 1)
	card2 = Card.new(:purple, :ovals, :solid,:two, 2)
	card3 = Card.new(:green, :diamond, :solid,:three, 3)
	assert_equal(false, Game.new.isSet?(card1, card2, card3))
    end

    # Testing addCards in Game.rb
    # Created and implemented on 05/25 by Zhengqi
    def test_adding__at_the_start_of_game
        #skip
        testObject = Game.new
        expectedObject = Game.new
        testObject.addCards
        
        expectedLength = expectedObject.table.length + 3
        assert_equal(expectedLength, testObject.table.length)
    end

    # Testing addCards in Game.rb
    # Created and implemented on 05/30 by Zhengqi
    def test_adding__after_removed_3_card
        #skip
        testObject = Game.new
        expectedObject = Game.new
        3.times{testObject.table.pop}
        testObject.addCards
        
        expectedLength = expectedObject.table.length
        assert_equal(expectedLength, testObject.table.length)
    end

    # Testing addCards in Game.rb
    # Created and implemented on 05/30 by Zhengqi
    def test_adding__twice
        #skip
        testObject = Game.new
        expectedObject = Game.new
        testObject.addCards
        testObject.addCards
        
        expectedLength = expectedObject.table.length + 6
        assert_equal(expectedLength, testObject.table.length)
    end

    # Testing removeCard in Game.rb
    # Created and implemented on 05/25 by Zhengqi
    def test_remove_once
        #skip
        testObject = Game.new
        expectedObject = Game.new
        testObject.userChoice = [1,2,3]
        testObject.removeCards

        expectedLength = expectedObject.table.length - 3
        assert_equal(expectedLength, testObject.table.length)
    end

    # Testing removeCard in Game.rb
    # Created and implemented on 05/25 by Zhengqi
    def test_remove_twice
        #skip
        testObject = Game.new
        expectedObject = Game.new
        testObject.userChoice = [1,2,3]
        testObject.removeCards
        testObject.userChoice = [1,2,3]
        testObject.removeCards

        expectedLength = expectedObject.table.length - 6
        assert_equal(expectedLength, testObject.table.length)
    end
	
    # Testing draw_a_card in Deck.rb
    # Created 05/29/2019 by Hannah 
    def test_draw_a_card2
        deck_object = Deck.new
        deck_object.draw_a_card
	deck_object.draw_a_card
	deck_object.draw_a_card
	deck_object.draw_a_card
        assert_equal(77, deck_object.deck.length)
    end

    # Testing draw_a_card in Deck.rb, test drawing all cards
    # Created 05/29/2019 by Hannah 
    def test_draw_a_card3
        deck_object = Deck.new
	for i in 0..80 do
        	deck_object.draw_a_card
	end
	assert_equal(0, deck_object.deck.length)
    end

    # Testing add_cards in Game.rb
    # addCards twice then check length of deck
    # Created 05/30/2019 by Hannah
    def test_addCards1
        game_object = Game.new
	expected_object = Game.new
       	game_object.addCards
        assert_equal(15, game_object.table.length)
	assert_equal(78, game_object.deck.length)
	assert_equal(expected_object.length-=3, game_object.length)
    end

    # Testing add_cards in Game.rb
    # Created 05/30/2019 by Hannah
    def test_addCards2
        game_object = Game.new
	expected_object = Game.new
       	game_object.addCards
	game_object.addCards
        assert_equal(18, game_object.table.length)
	assert_equal(75, game_object.deck.length)
	assert_equal(expected_object.length-=6, game_object.length)
    end

end

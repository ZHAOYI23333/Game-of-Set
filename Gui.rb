=begin 
File name: shoes.rb
Description: The SET GAME GUI
Functionalities: 2-Player Mode, Play with Robot, Adjustable Difficulty Level, Visualized Timer, Hint, Manu

Log: 
5/28: Created by Yi, Implemented by Yi
5/29: Extra features mostly functional. Add one player mode (play against computer) with
    3 level of difficulty, hint, timer, and finally the basic version: two player mode.
5/30: Completely tested on Mac OS and Linux Ubuntu 16.04. Different platform may look slightly different.
5/31: Tested and documented by Yi.
=end

require_relative 'Deck.rb'
require_relative 'Card.rb'
require_relative 'Game_for_Gui.rb'

# Main program start with the "Manu" window. 
Shoes.app(width: 300, height:110, resizable: false, :title => 'GAME SET') do
    # Background color => customized green 
    background rgb(240, 250, 208)

    # "Manu" element
    manu_page = flow(title: "Manu") {

        # paragraph line. Introduction 
	    stack {para "Welcome to Game Set !" , :stroke => purple, font: "American Typewriter 15", :margin_left => 36, :margin_top => 20 }
        # Define list_box with 3 mode: Read rules, 1P and 2P
        items = ["Read Game Rules", "Play Against Bot", "Play With My Friend"]
        list_box  width:170, :items => items, :choose => items[0], font: "Sans Bold 6" , :margin_left => 30,  :margin_top => 2 do |list|
            @selection = list.text
        end

        # Define a button. Click to enter corresponding sub_windows
        button("START", :margin_left => 30)  do 

            case @selection

            when "Play Against Bot"
                
                # Single Player Mode: Play with Computer Robot(Timer) with 4 difficulty level
                # New game window prompts out
                window(width: 300, height:100, resizable: false) do 

                    background rgb(255, 229, 204)
                    # A small window provided for choosing difficulty levels.
                    choose_difficult_page = flow {
                        # Create a hash to define corresponding difficulty coefficient which is used in progress bar.
                        setting_level = { "Robot with CORE i7" => 2000.0, "Robot with CORE i9" => 1000.0, "Robot TYP-HD" => 50.0 } # 60s, 40s, 20s, 1s.
                        setting_level.default = 3000.0
                        # Create a list_box to get user choice
                        stack { para "Please choose level :", :stroke => purple, font: "American Typewriter 14", :margin_left => 48, :margin_top => 20 }
                        level_list = ["Robot with CORE i5", "Robot with CORE i7", "Robot with CORE i9","Robot TYP-HD"]
                        list_box  width:175, :items => level_list, :choose => level_list[0], font: "Sans Bold 6" ,
                            :margin_left => 30,  :margin_top => 2 do |d|
                            @@speed = setting_level[d.text]
                        end
                        @@speed = 3000.0

                        # Button to the new window 
                        button("GO!", :margin_left => 30) do

                            # Close the page that choosing the difficulty level. Do not need it anymore
                            self.close
                            # Get player name. "Anonymous" if player leave it empty
                            name1 = ask("Please enter your name:")
                            name1 = name1.length>0 ? name1:"Anonymous"
                            
                            # Window for the core game
                            window width: 792,height:540 do

                                background rgb(240, 250, 208)
                                # Create a new game object
                                game = Game.new
                            
                                # Make sure table is initialized with a set.
                                while game.findSet == nil do 
                                    game.addCards
                                end
                            
                                # Display table (score board, cards, buttons, timer)
                                flow width:792 do
                                    # score board for P1               
                                    flow  do
                                        # Score board. Display scores for player and ROBOT
                                        @score = inscription strong("#{name1}"),"'s Score: #{game.score}\t\t\t", :stroke => purple
                                        @score_2 = inscription strong("ROBOT"),"'s Score: #{game.score_2}", :stroke => blue
                                    end

                                    f = flow {
                                        @tableCheck = game.table.map do |card|
                                            flow(width:132) {image card.path; @c = check; para "   Card #{game.table.index(card)+1}"} 
                                            [@c,card] # table => array of [check, card]
                                            end
                                    }
                            
                                    # Create "Pause" button to stop the timer.
                                    button "PAUSE" do
                                        @animate.toggle
                                    end
                            
                                    # Create "HINT" button. Hint will give user a card that can make up a set.
                                    button "HINT" do 
                                        hint = game.table.index(game.findSet)
                                        wholehint = game.findHint[0]
                                        alert("Hint: You can construct a set using card #{wholehint}!") 
                                    end

                                    # Create "TEST" button for grader to show the set directly. Player are not supposed to click that.
                                    button "TEST" do 
                                        hint = game.table.index(game.findSet)
                                        wholehint = game.findHint.join(', ')
                                        alert("TEST: You can construct a set using card #{wholehint}!") 
                                    end
                            
                                    # Create "SUBMIT" button, as well as implementing the game logic
                                    button "SUBMIT" do
                                        # array of card that has been selected.
                                        selected = @tableCheck.map { |c, card| card if c.checked? }.compact
                                        if selected.length != 3 # Not a legal selection
                                            alert("You've selected #{selected.length} cards ! \nPlease choose exactly 3 cards !")
                                        else  # User choosed 3 cards
                                            game.userChoice = selected # Copy the reference
                                            if game.isSet? selected[0], selected[1], selected[2]
                                                # Add score. Update score board
                                                game.score = game.score + 1
                                                @score.replace strong("#{name1}"),"'s Score: #{game.score}\t\t\t", :stroke => purple
                                                # Remove the chosen cards and notify player.
                                                game.table = game.table - game.userChoice
                                                alert("Congratulation #{name1} !\nYou've found a set !")
                                                # Check if it's time to end the game. We stop if @score + @score_2 = 21, which means 18 cards left.
                                                # Since 21 cards can make sure there is a set in it, we'd to stop here when 18 cards remains.
                                                if game.table.length + game.deck.length <= 18
                                                    # As @score + @score_2 = 21, there won't be a tie. 
                                                    alert(game.score > game.score_2 ? "Congratulation #{name1} ! YOU WON !" : "YOU LOSE! HAHAHA ... "  )
                                                    self.close # Close game window after game stops.
                                                end
                                                # Add cards if and only if: table has less than 12 cards or there is no set on table
                                                while (game.table.length < 12) or (game.findSet == nil) do
                                                    game.addCards
                                                end 
                                                f.clear{
                                                    # Update the cards on table to make sure @tableCheck is updated
                                                    @tableCheck = game.table.map do |card|
                                                    flow(width:132) {image card.path; @c = check; para "   Card #{game.table.index(card)+1}"} 
                                                    [@c,card] # @tableCheck => array of [check, card]
                                                    end } 
                                            else
                                                # If player got wrong, no penalty will be made. Just give alert.
                                                alert("What a pity ! \nIt's not a set !")
                                            end
                                        end
                                    end
                                    
                                    # Create a timer to tell player about ROBOT's progress
                                    @p = progress width: 200
                                    @animate = animate(50) do |i|
                                        # The time is determined by the mode chosen before game. ROBOT will find a set for every @@speed/50 second. 
                                        @p.fraction = (i % @@speed) / @@speed
                                        if (i % @@speed == @@speed - 1)  # For every @@speed/50 second
                                            # Change and Update score, get player notified, remove cards and add cards(if needed). Check if game ends.
                                            game.score_2 = game.score_2 + 1
                                            @score_2.replace strong("ROBOT"),"'s Score: #{game.score_2}", :stroke => blue
                                            alert("ROBOT has found a set: Card "+game.findHint.join(', '))
                                            game.table = game.table - game.findSet
                                            if game.table.length + game.deck.length <= 18
                                                alert(game.score > game.score_2 ? "Congratulation #{name1} ! YOU WON !" : "YOU LOSE! HAHAHA ... "  )
                                                self.close # Close game window after game stops.
                                            end
                                            while (game.table.length < 12) or (game.findSet == nil) do
                                                game.addCards                                            
                                            end 
                                                # Update cards on table
                                            f.clear{
                                                @tableCheck = game.table.map do |card|
                                                flow(width:132) {image card.path; @c = check; para "   Card #{game.table.index(card)+1}"} 
                                                [@c,card] # @tableCheck => array of [check, card]
                                                end
                                            } 
                                        end
                                    end
                                    # Short text line to describe the progress bar
                                    inscription "Processing ... ROBOT IS SCANNING !", :stroke => red
                            
                                end
                            end
                        end
                    }
                end
                # Single Player Mode End Here

            when "Play With My Friend"
                
                # Two Player Mode: Play with Friends! 
                # New game window prompts out
                name1 = ask("Please enter name for PLAYER ONE:")
                name1 = name1.length>0 ? name1:"Anonymous"
                name2 = ask("Please enter name for PLAYER TWO:")
                name2 = name2.length>0 ? name2:"Anonymous"
                
                window width: 792,height:540 do

                    background rgb(240, 250, 208)
                    game = Game.new
                
                    while game.findSet == nil do 
                        game.addCards
                    end
                
                    flow width:792 do
         
                        flow  do
                            # Score board
                            @score = inscription strong("#{name1}"),"'s Score: #{game.score}\t\t\t", :stroke => purple
                            @score_2 = inscription strong("#{name2}"),"'s Score: #{game.score_2}", :stroke => blue
                        end

                        f = flow {
                            @tableCheck = game.table.map do |card|
                                flow(width:132) {image card.path; @c = check; para "   Card #{game.table.index(card)+1}"} 
                                [@c,card] # @tableCheck => array of [check, card]
                                end
                        }
                
                        # Create "RULE" button to tell player the rule of game
                        button "RULE" do 
                            alert("Welcome to the game SET created by Team TYP-HD! \n\nIn this game, you and your friends are supposed to find 21 sets (63 cards)as quick as possible! \n\nIf you see a set, click SUBMIT before your friend do!") 
                        end
                
                
                        # Create "HINT" button. Click to get a hint
                        button "HINT" do 
                            hint = game.table.index(game.findSet)
                            wholehint = game.findHint[0]
                            alert("Hint: You can construct a set using card #{wholehint}!") 
                        end

                        button "TEST" do 
                            hint = game.table.index(game.findSet)
                            wholehint = game.findHint.join(', ')
                            alert("TEST: You can construct a set using card #{wholehint}!") 
                        end
                
                        # Create "SUBMIT" button, as well as implementing the game logic
                        button "P1 SUBMIT" do
                            selected = @tableCheck.map { |c, card| card if c.checked? }.compact
                            if selected.length != 3
                                alert("You've selected #{selected.length} cards ! \nPlease choose exactly 3 cards !")
                            else  
                                game.userChoice = selected
                                res = game.isSet? selected[0], selected[1], selected[2]
                                if res 
                                    #game.table.map! {|c, card| card}# table => array of cards
                                    game.score = game.score + 1
                                    @score.replace strong("#{name1}"),"'s Score: #{game.score}\t\t\t", :stroke => purple
                                    alert("Congratulation #{name1} !\nYou've found a set !")
                                    game.table = game.table - game.userChoice
                                    if game.table.length + game.deck.length == 18
                                        winner = game.score > game.score_2 ? name1: name2
                                        alert ("Congratuations on #{winner} ! YOU WIN !\nYour score is #{[game.score, game.score_2].max} !")
                                        self.close
                                    end
                                    while (game.table.length < 12) or (game.findSet == nil) do
                                        game.addCards
                                    end 
                                    f.clear{
                                        @tableCheck = game.table.map do |card|
                                        flow(width:132) {image card.path; @c = check; para "   Card #{game.table.index(card)+1}"} 
                                        [@c,card] # @tableCheck => array of [check, card]
                                        end } 
                                else
                                    alert("What a pity! \nIt's not a set!")
                                end
                            end
                        end
                        
                        
                        button "P2 SUBMIT" do
                            selected = @tableCheck.map { |c, card| card if c.checked? }.compact
                            if selected.length != 3
                                alert("You've selected #{selected.length} cards ! \nPlease choose exactly 3 cards !")
                            else  
                                game.userChoice = selected
                                res = game.isSet? selected[0], selected[1], selected[2]
                                if res 
                                    #game.table.map! {|c, card| card}# table => array of cards
                                    game.score_2 = game.score_2 + 1
                                    @score_2.replace strong("#{name2}"),"'s Score: #{game.score_2}", :stroke => blue
                                    alert("Congratulation #{name2} !\nYou've found a set !")
                                    game.table = game.table - game.userChoice
                                    if game.table.length + game.deck.length == 18
                                        winner = game.score > game.score_2 ? name1: name2
                                        alert ("Congratuations #{winner} ! YOU WIN !\nYour score is #{[game.score, game.score_2].max} !")
                                        self.close
                                    end
                                    while (game.table.length < 12) or (game.findSet == nil) do
                                        game.addCards
                                    end 
                                    f.clear{
                                        @tableCheck = game.table.map do |card|
                                        flow(width:132) {image card.path; @c = check; para "   Card #{game.table.index(card)+1}"} 
                                        [@c,card] # @tableCheck => array of [check, card]
                                        end } 
                                else
                                    alert("What a pity ! \nIt's not a set !")
                                end
                            end
                        end
                        
                
                    end
                
                
                end
                # Two Player Mode End Here

            else 
                # default case: Open Game Rule Introduction
                window(width: 800, height:580) do
                    background rgb(255, 255, 208) 
                    para "The GAME SET created by TYP-HD has 2 mode: SINGLE PLAYER MODE or TWO PLAYER MODE. 
\nIn the SINGLE PLAYER MODE, you need to choose the difficulty level before game starts. In the game, you are supposed to find set as quick as possible(otherwise robot will find it and earn score!). The robot will find a set within a specific time period, depending on what difficulty level you chose. For example, if you choose \"ROBOT with Core i5\", the robot will find a set every 60 seconds. 
\nOn the bottom of the window, there is a \"PAUSE\" button which allows you to pause and restart, a \"HINT\" button which will give you a little hint, a \"TEST\" button which provided answer for developer ONLY. Of course, a \"SUBMIT\" button to submit the set you've found! Once a correct submission is made, your score will add 1 and the chosen cards will be removed from table, and new cards will be added into it. The table will always ensure there is a set, so there could be few times you see 15, or even more cards on the table. A progress bar is provided for you as well to know ROBOT's progress.
\nThe score is calculated based on how many sets you've found. 1 points for each set, and no penalty if you choose wrong. It's same for ROBOT!
\nOnce 21 sets are founded, the game is ended. For a random generated deck, it's always ensured to have 21 sets. So there will be no tie, and your job is trying your best to beat the robot!
\nIn the TWO PLAYER MODE, you are playing with your friends. You and your friend will be looking for a set. If one of you has found a set first --- click corresponding SUBMIT button before the other did! (each player has their own button to submit). No penalty for wrong sets, and try your best to beat your friends!
\nHINT button is provided if you need it. Better discuss with your friend before game start to determine whether you need to use this button or not! Hint is for everyone so it is definitely fair to use.
\nFinally, hope you enjoy the game!
\n\tBest,\n\t\tTeam TYP-HD", font: "Arial, 10"
                end

            end

        end
    
    }
        
end
# Project 2
### Game of Set

### Roles
* Overall Project Manager: Yi Zhao
* Coding Manager: Trevor Shirey
* Testing Manager: Zhengqi Dong
* Documentation: Hannah McCullough

### Contributions
Please list who did what for each part of the project.
Also list if people worked together (pair programmed) on a particular section.

* Yi: Implemented Card.rb (whole file), Deck.rb (whole file), Gui.rb (whole file) and printTable (function) in Game.rb. Refactored Game_for_gui.rb Fixed bugs for initialize, findSet and getUsersCardInput (functions) in Game.rb. Did unit tests on Card.rb and Deck.rb, and also did the integration test as well as the system test on GUI. Did documentations for all codes I've written and the GUI guide down below in README.md

* Hannah: Checked spelling and clarity in documentation. Made some test cases for addCards and draw_a_card. Implemented getUserInput function.

* Trevor: Merged all versions of command line game into a single working version. Fixed documentation and design issues in command line version of the game. Helped design core game functionality. Tested and refined command line version at system level.
Functions implemented in Game.rb: main, findSet, Initialize, printHint
Functions modified/updated in Game.rb: printTable, getAttributeHint, removeCards

* Pranay: Implemented functionality for:
(i) isSet? card1, card2, card3 - function takes 3 card objects as parameters and returns a boolean if they form a set or not.
(ii) initialHint card1, card2, card3 - function gives the user a hint on finding the set in the given game by displaying information on the number of similar and distinct categories the cards of the set take.
    - Provided unit test cases for both the functions.
    - Fixed bugs in driver(main) code
    - Used TTD to identify faulty code in file Game.rb
    - Indented code to make sure not loose ends were left hanging.
* Drago (Zhengqi):
Implement the methods, addCards and removeCards, and write test cases, specifications for these two methods. 
Revised the findSet method which allow the implementation of updated hint after each round.
Developed the "main methods", applying the case statement to replace the original a series of if-else statement, and Provide functionality of updated hint, score tracking system, and Quit game option that allow user to quit at any Entering time.
Add more specific intruction for user interface, and appropritate prompt error for each boundary case.
Did the integration testing for each options provide for user, and fixed all the error that occured, and provides appropriate haddle.


### Guide
This project is to implement the game SET. The file contains: Card.rb, Deck.rb, Game.rb, Game_for_gui.rb, Gui.rb, image(folder), testing(folder), README.md

For basic rules of set, [here](https://en.wikipedia.org/wiki/Set_(card_game)) is a link that you can refer to. Based on general rules of set, we made additional assumptions on how this game will be operated:  
- The table will ensure there is a set. It contains at least 12 cards. If there is no set among 12, we keep adding 3 cards until set exists.
- 3 cards will be added if and only if: either table has less than 12 cards or table has so set.
- Once user choose correct set, 3 corresponding cards will be removed and new cards will be pushed from the end of table.
- Hint is always available to give a card as hint. No points will be taken off because of using hint or submit a wrong set. 
- The whole deck has 81 cards. 21 cards will ensure the existence of a set. Thus, we decided that the game will end when there is only 18 cards left, i.e., 21 sets are found(since then we cannot make sure a set is definitely exist)
- User cannot click "TEST" button while playing against computer. That's for the convenience of testing, not playing. 

#### GUI Version
To start running GUI version, first install SHOES on your platform. 

Here is a link to the [download page](http://shoesrb.com/). (Notice: The final version of GUI is tested on Mac OS. The interface may looks different Windows due to different font and button size, but the functionality of game remains the same.) We tested it on Ubuntu 16.04 and Mac OS. 

Open the application after installation, and click “Run” button and choose Gui.rb in file “Project-2-TYP-HD”. Then the menu page should prompt out and the game starts.
For more information about how to play this game, please click “Read Game Rules” after you run the Gui.rb. 

Briefly, there is a single player mode which has adjustable difficulty levels, timer, a robot competitor and a hint function. Besides, there is a two player mode which allows you to compete with your friend. Hint is always welcome to use -- as it's designed to make the game easier for both of you!

#### Command Line Version
To run the game or start a new game, change directory to local file and type the command below:
```
$ ruby Game.rb
```
At the beginning of the game, the user can input the number of players.Then a table listing the available cards will be displayed in the window. Each card is described in plain English, with the attributes: color, shape, fill, and number. 

The user can select 0 for a hint and a single card contained in an available set will be given as well as the common attributes it has to the other 2 cards in the set. The second time a user asks for a hint another card is given and each time after that a message is given describing the available set. Once the player has selected 3 cards they are either awarded 3 points for a correct set or penalized 1 point for an incorrect set. Then the next player has a chance to find a set. This repeats until the game ends or a user enters q as an input anytime. When the game ends or when the user quits the scores for all the players are shown.




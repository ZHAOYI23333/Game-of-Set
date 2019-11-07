### Game of Set

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


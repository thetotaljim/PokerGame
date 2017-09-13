# Poker/War iOS Game Application

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)
[![Awesome Badges](https://img.shields.io/badge/badges-awesome-green.svg)](https://github.com/Naereen/badges)
[![HitCount](http://hits.dwyl.io/thetotaljim/PokerGame.svg)](http://hits.dwyl.io/thetotaljim/PokerGame)

> This is a Poker/War Game Application written in Objective-C.  

This project was developed using a test driven software development process. The file structure follows Apple's Model-View-Controller communication pattern.  

![Picture](https://github.com/thetotaljim/PokerGame/blob/master/Assets/PokerHome.png)
![Picture](https://github.com/thetotaljim/PokerGame/blob/master/Assets/PokerPlayerWin.png)

## Requirements

Xcode and Apple Developer Account

## Installation

To use this application, download the repository, and open in Xcode.  

## Usage Example

The game begins with a homepage where you enter some personal information. You then move to the next view, where you select an avatar. 

![Picture](https://github.com/thetotaljim/PokerGame/blob/master/Assets/PokerAvatar.png)

Then you select a game and difficulty level.  You also have the option to view the instructions for both of the games included in the application.

![Picture](https://github.com/thetotaljim/PokerGame/blob/master/Assets/PokerGameDifficulty.png)
![Picture](https://github.com/thetotaljim/PokerGame/blob/master/Assets/PokerInstructionPage.png)

When you either lose or win, you return to the game selection page, where your statistics from previous games are displayed.

![Picture](https://github.com/thetotaljim/PokerGame/blob/master/Assets/GameResults.png)

## Contents 

Here is a list of the included files and their usage in this project (located in the main PokerGame folder):

* ``` CardPlayer.h & CardPlayer.m ```
  * Data structure used to hold player data.
* ``` DetailsController.h & DetailsController.m ```
  * Controller for the game, difficulty and instruction selection page.
* ``` GameController.h & GameController.m ```
  * Controller that handles the poker game.  Includes the function for checking hand rank.
* ``` IconController.h & IconController.m ```
  * Controller that handles icon selection.
* ``` PGCard.h & PGCard.m ```
  * Data structure used to hold card data.
* ``` PGDeck.h & PGDeck.m ```
  * Data structure to create a deck of PGCards.
* ``` PokerInstructions.h & PokerInstructions.m ```
  * Gives instructions to the poker game.
* ``` ViewController.h & ViewController.m ```
  * Controls first page where user inputs data before moving to the icon selection page.
* ``` WarControllerViewController.h & WarControllerViewController.m ```
  * This controller handles the War game.
* ``` WarInstruction.h & WarInstructions.m ```
  * Gives instructions to the War game. 
* ``` .png files ```
  * Image assests including icons, cards, cannon, money, and title.
 
## Meta

Jim Steimel [@jimsteimel](https://twitter.com/jimsteimel) - jim@thetotaljim.com - www.thetotaljim.com

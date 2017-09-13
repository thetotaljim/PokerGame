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

The game begins with a homepage where you select the difficulty level:

![Picture](https://github.com/thetotaljim/HMan/blob/master/Assets/hangmanHome.png)

Then you just play following normal hangman rules!

![Picture](https://github.com/thetotaljim/HMan/blob/master/Assets/hangman2.png)

## Contents 

Here is a list of the included files and their usage in this project (located in the main HMan folder):
* Models
  * ``` InitialModel.swift ```
    * Used to determine the the user's selected difficulty 
  * ``` GameModel.swift ```
    * Here the game is played. Functions for selecting words and tracking the progress of each turn are included in this file.
  * ``` FinalModel.swift ```
    * This file displays the results of the game.
  * ``` MyPropertyList.plist ```
    * Contains the words to be guessed.
* Views  
  * ``` HangmanView.swift ```
    * This file uses iOS Core Graphics to draw the hangman.
  * ``` TitleView.swift ```
    * Displays the home page of the application.
* Controllers
  * ``` InitialViewController.swift ```
    * Handles user input of difficult level.
  * ``` GameViewController.swift ```
    * Controls letter selection and seques to initial and final views.
  * ``` FinalViewController.swift ```
    * This View handles how the results are displayed.
 
## Meta

Jim Steimel [@jimsteimel](https://twitter.com/jimsteimel) - jim@thetotaljim.com - www.thetotaljim.com

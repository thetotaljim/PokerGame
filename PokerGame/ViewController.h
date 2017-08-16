//
//  ViewController.h
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CardPlayer.h"
#import "PGDeck.h"
#import "PGCard.h"

/************************************************
 
 The first view will ask your name and other info.

*************************************************/


@interface ViewController : UIViewController

//  This is the custom item that stores player data. Used in different views.
@property CardPlayer *myPlayer;


@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *continueView2;
- (IBAction)pressToView2:(id)sender;

@end


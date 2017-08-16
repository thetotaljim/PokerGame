//
//  WarControllerViewController.h
//  PokerGame
//
//  Created by James Steimel on 8/2/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "ViewController.h"
#import "PGCard.h"
#import "PGDeck.h"
#import "CardPlayer.h"
#import "UIKit/UIKit.h"

@interface WarControllerViewController : ViewController

@property PGCard *playerC;
@property PGCard *compC;
@property Boolean leavingWar;
@property Boolean needAReset;

/****************************************/

@property NSMutableArray *potHand;
@property Boolean firstHand;
@property Boolean warTime;


/****************************************/

@property PGDeck *myDeck;
@property NSMutableArray *playerHand;
@property NSMutableArray *compHand;

/*****************************************/
@property (weak, nonatomic) IBOutlet UIImageView *warLogo;

@property (weak, nonatomic) IBOutlet UIImageView *imagePC1;
@property (weak, nonatomic) IBOutlet UIImageView *imagePC2;
@property (weak, nonatomic) IBOutlet UIImageView *imagePC3;
@property (weak, nonatomic) IBOutlet UIImageView *imagePC4;
@property (weak, nonatomic) IBOutlet UIImageView *imagePC5;

@property (weak, nonatomic) IBOutlet UIImageView *imageCC1;
@property (weak, nonatomic) IBOutlet UIImageView *imageCC2;
@property (weak, nonatomic) IBOutlet UIImageView *imageCC3;
@property (weak, nonatomic) IBOutlet UIImageView *imageCC4;
@property (weak, nonatomic) IBOutlet UIImageView *imageCC5;

@property (weak, nonatomic) IBOutlet UIButton *buttonPC1;
- (IBAction)pressedPC1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonPC2;
- (IBAction)pressedPC2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonPC3;
- (IBAction)pressedPC3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonPC4;
- (IBAction)pressedPC4:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonPC5;
- (IBAction)pressedPC5:(id)sender;

/************************************************************/

@property (weak, nonatomic) IBOutlet UIButton *buttonCC1;
- (IBAction)pressedCC1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonCC2;
- (IBAction)pressedCC2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonCC3;
- (IBAction)pressedCC3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonCC4;
- (IBAction)pressedCC4:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonCC5;
- (IBAction)pressedCC5:(id)sender;
/*************************************************************/

@property (weak, nonatomic) IBOutlet UIButton *nextCardButton;
- (IBAction)pressedNextCard:(id)sender;

/*************************************************************/
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerIconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;





@end

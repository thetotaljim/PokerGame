//
//  GameController.h
//  PokerGame
//
//  Created by James Steimel on 7/26/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPlayer.h"
#import "PGCard.h"
#import "PGDeck.h"
#import "CardPlayer.h"



@interface GameController : UIViewController




//  CUSTOM METHODS

-(void)takeMinBet;
-(void)turnOffBetCallFold;
-(void)turnOnBetCallFold;
-(NSMutableArray*)replaceCardsInPlayerHand;
-(void)resetForNextHand;
-(void)updatePlayerCards;
-(void)updateMonies;
-(void)disableCards;
-(void)turnOffHighlightedBooleans;
-(void)dealHandsFromMyDeck;
-(void)enableCards;
-(void)updateComp2Cards;
-(int)getHandRank: (NSMutableArray *) hand;
-(NSMutableArray *)sortArrayHighToLow: (NSMutableArray*)arr;
-(void)determineWinnerFromPlayer: (int) p andComp: (int) c;
-(NSMutableArray*)getRankArrayForHand: (NSMutableArray*)hand;

/*
    Values for playing the game
*/

@property NSMutableArray *playerCardButtonArray;
@property int compDiffLevel;
@property Boolean gameOver;
@property Boolean compCall;
@property Boolean compFold;
@property Boolean compFoldReset;
@property CardPlayer *myPlayer;
@property PGDeck *myDeck;
@property int pot;
@property int playerMonies;
@property int compMonies;
@property int handPos;
@property Boolean callOnly;
@property int numCardsSelected;
@property NSMutableArray *playerHand;
@property NSMutableArray *compHand;




/*
 Properties used by the hand ranking functions.
 */

@property Boolean playerWins;
@property Boolean compWins;
@property Boolean tie;

@property Boolean straightFlush;    // = 1
@property Boolean fourKind;         // = 2
@property Boolean fullHouse;        // = 3
@property Boolean flush;            // = 4
@property Boolean straight;         // = 5
@property Boolean threeKind;        // = 6
@property Boolean twoPair;          // = 7
@property Boolean pair;             // = 8
@property Boolean highCard;         // = 9

@property Boolean isHandStart;


/*
    These are for the buttons, to highlight
    and unhighlight the cards.
*/

@property Boolean isHighlighted1;
@property Boolean isHighlighted2;
@property Boolean isHighlighted3;
@property Boolean isHighlighted4;
@property Boolean isHighlighted5;


/*
    The cards.
*/

@property (weak, nonatomic) IBOutlet UIImageView *playerC1;
@property (weak, nonatomic) IBOutlet UIImageView *playerC2;
@property (weak, nonatomic) IBOutlet UIImageView *playerC3;
@property (weak, nonatomic) IBOutlet UIImageView *playerC4;
@property (weak, nonatomic) IBOutlet UIImageView *playerC5;

@property (weak, nonatomic) IBOutlet UIImageView *compC1;
@property (weak, nonatomic) IBOutlet UIImageView *compC2;
@property (weak, nonatomic) IBOutlet UIImageView *compC3;
@property (weak, nonatomic) IBOutlet UIImageView *compC4;
@property (weak, nonatomic) IBOutlet UIImageView *compC5;


/*
    Player stats properties
*/
@property (weak, nonatomic) IBOutlet UILabel *compMoneyLabel;@property (weak, nonatomic) IBOutlet UILabel *testDisplayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *winLossLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerMoniesLabel;
@property (weak, nonatomic) IBOutlet UILabel *potLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerRecord;
@property (weak, nonatomic) IBOutlet UIImageView *chipIcon;

/*
    bottom bar properties
*/

@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;
- (IBAction)startSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *betButton;
- (IBAction)betSelected:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *callButton;
- (IBAction)callSelected:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *foldButton;
- (IBAction)foldSelected:(id)sender;

/*
        NOW THE BUTTONS TO 
        PLACE OVER MY IMAGEVIEWS
*/


@property (weak, nonatomic) IBOutlet UIButton *pC1button;
- (IBAction)pressedPC1:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *pC2button;
- (IBAction)pressedPC2:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *pC3button;
- (IBAction)pressedPC3:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *pC4button;
- (IBAction)pressedPC4:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *pC5button;
- (IBAction)pressedPC5:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *finishedButton;
- (IBAction)pressedFinishButton:(id)sender;



















@end

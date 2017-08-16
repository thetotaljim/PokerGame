//
//  IconController.h
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGCard.h"
#import "PGDeck.h"
#import "CardPlayer.h"

@interface IconController : UIViewController

@property CardPlayer *myPlayer;

@property (weak, nonatomic) IBOutlet UIButton *icon1;
@property (weak, nonatomic) IBOutlet UIButton *icon2;
@property (weak, nonatomic) IBOutlet UIButton *icon3;
@property (weak, nonatomic) IBOutlet UIButton *icon4;
@property (weak, nonatomic) IBOutlet UIButton *icon5;
@property (weak, nonatomic) IBOutlet UIButton *icon6;
- (IBAction)selectIcon6:(id)sender;

- (IBAction)selectIcon1:(id)sender;
- (IBAction)selectIcon2:(id)sender;
- (IBAction)selectIcon3:(id)sender;
- (IBAction)selectIcon4:(id)sender;
- (IBAction)selectIcon5:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *continueButton;

- (IBAction)pressToView3:(id)sender;


@end

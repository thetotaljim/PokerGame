//
//  DetailsController.h
//  PokerGame
//
//  Created by James Steimel on 7/26/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPlayer.h"

@interface DetailsController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property CardPlayer *myPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *playerIcon;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;


@property (weak, nonatomic) IBOutlet UIButton *continueButton;

- (IBAction)pressContinueButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIPickerView *difficultyPicker;
@property (weak, nonatomic) IBOutlet UILabel *warLabel;
@property (weak, nonatomic) IBOutlet UIButton *warButton;
- (IBAction)warButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *pokerLabel;


@end

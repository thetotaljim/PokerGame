//
//  WarInstructions.h
//  Steimel_James_P4
//
//  Created by James Steimel on 8/3/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "ViewController.h"

@interface WarInstructions : ViewController

@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UILabel *textInstructionsLabel;

@property (weak, nonatomic) IBOutlet UIButton *contButton;
- (IBAction)pressedContButton:(id)sender;


@end

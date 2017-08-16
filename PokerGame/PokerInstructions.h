//
//  PokerInstructions.h
//  Steimel_James_P4
//
//  Created by James Steimel on 8/3/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "ViewController.h"

@interface PokerInstructions : ViewController
@property (weak, nonatomic) IBOutlet UIButton *moveToPoker;
- (IBAction)pressedMoveToPoker:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *handImage;


@end

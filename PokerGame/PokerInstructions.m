//
//  PokerInstructions.m
//  Steimel_James_P4
//
//  Created by James Steimel on 8/3/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "PokerInstructions.h"

@interface PokerInstructions ()

@end

@implementation PokerInstructions

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *myInstructions = @"This is a version of 5 Card Draw.  Player and Computer both ante $1 before hand begins. Each hand is two turns long. Before each turn, you have the option of betting $1, calling (no bet), or folding (ending the hand). If you bet, the computer may call or fold, depending on it's hand. After deciding on one of these three, you have the chance to replace 3 of the cards in you hand. Do by clicking on the cards you want to replace (0-3), and the pressing the Finished button.  You win when the computer is out of money. GOOD LUCK!";
    self.instructionsLabel.text = myInstructions;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressedMoveToPoker:(id)sender {
}
@end

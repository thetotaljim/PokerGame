//
//  WarInstructions.m
//  Steimel_James_P4
//
//  Created by James Steimel on 8/3/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "WarInstructions.h"

@interface WarInstructions ()

@end

@implementation WarInstructions

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        NSString *myInstructions = @"War is a very simple game. The deck is shuffled and split between players. Press next card to place a card face down.  Highest card between player and computer wins (suit indifferent). Winner takes the cards. If the two cards are the same rank, then each player will lay down 4 cards.  The higher rank of the last cards is the winner.  If your opponent runs out of cards first, you win, otherwise, you lose. GOOD LUCK!";
    self.textInstructionsLabel.text = myInstructions;
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

- (IBAction)pressedContButton:(id)sender {
}
@end

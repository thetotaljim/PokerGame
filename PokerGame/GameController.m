//
//  GameController.m
//  PokerGame
//
//  Created by James Steimel on 7/26/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "GameController.h"

@interface GameController ()

@end

@implementation GameController

/*  ************************************************************
    ************************************************************
                    VIEW DID LOAD
    ************************************************************
    ************************************************************
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*  Instanciate a CardPlayer and deck of cards.         */
    self.myPlayer = [CardPlayer sharedPlayer];
    self.myDeck = [[PGDeck alloc]init];
    
    //  these hold the player and computer hands
    self.playerHand = [NSMutableArray array];
    self.compHand = [NSMutableArray array];
    
    //  These values are for tracking game progress.
    [self resetValuesForNewGame];
    /*
     Create a UIImageView. Set the frame size to the parent's (self) frame
     size.
     */
    UIImage *backgroundImage = [UIImage imageNamed:@"perlinfelt1.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    /*
        This is so i can add some action (maybe an alert) to the
        player icon on the game screen.
    */
    [self.playerIcon setImage:[UIImage imageNamed:self.myPlayer.iconPath]];
    [self.playerIcon setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.playerIcon addGestureRecognizer:singleTap];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.myPlayer.firstName, self.myPlayer.lastName];
    self.finishedButton.enabled = NO;
    // Disable player cards
    [self disableCards];

}

-(void)resetValuesForNewGame{
    self.pot = 0;
    self.playerMonies = 25;
    self.compMonies = 25;
    self.handPos = 0;
    self.callOnly = NO;
    self.numCardsSelected = 0;
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

/*  ************************************************************************
    ************************************************************************
                            START BUTTON CODE
    ************************************************************************
    ************************************************************************
*/

- (IBAction)startSelected:(id)sender {
    
    [self takeMinBet];  // pot++, user--
    [self takeOneFromCompForPot];
    [self updateMonies];
    
    self.testDisplayLabel.text = @"If you would like to bet before swapping cards, press BET. Otherwise, choose CALL to continue or FOLD to end hand.";
    [self turnOffHighlightedBooleans];  // Resetting the cards for selection
    self.handPos = 0;   //  Used to track what part of the hand we are at.
    [self.myDeck shuffleDeck];
    
    /*  Here I add cards to the NSMutableArrays that i declared for the player and computer hands.  */
    [self dealHandsFromMyDeck];
    [self updatePlayerCards];
    [self updateComp2Cards];
    self.startButton.enabled = NO;  // Once game has started, start button disabled.
    [self turnOnBetCallFold];
    self.handPos++;
    
}


/*  ********************************************************
    ********************************************************
            FINISH BUTTON CODE
    ********************************************************
    ********************************************************
*/

-(void)setPlayerWinsLossesLabel{
    NSString *label = [NSString stringWithFormat:@"W: %d  L: %d", self.myPlayer.wins, self.myPlayer.losses];
    self.playerRecord.text = label;
}

- (IBAction)pressedFinishButton:(id)sender {
    
    if(self.gameOver == YES){
        
        [self setPlayerWinsLossesLabel];
        [self.finishedButton setTitle:@"Finished!" forState:UIControlStateNormal];
        self.isHandStart = YES;
        self.playerMonies = 25;
        self.compMonies = 25;
        self.handPos = 0;
        self.isHandStart = YES;
        self.gameOver = NO;
    }
    
    if(self.isHandStart == YES){
        
        self.isHandStart = NO;
        [self resetForNextHand];
        [self.finishedButton setTitle:@"FINISHED" forState:UIControlStateNormal];
        self.playerWins = NO;
        self.compWins = NO;
        self.tie = NO;
    }
    
    /*  ****************************************************
                    Hand Pos 1 Begins
        ****************************************************
    */
    if(self.handPos == 1){
        
        self.isHandStart = NO;
        [self disableCards];
        if(self.numCardsSelected < 4){
            self.playerHand = [self replaceCardsInPlayerHand];
            //  UPDATE THE PLAYER CARD IMAGEVIEWS
            [self updatePlayerCards];
            [self turnOnBetCallFold];
            [self disableCards];
            
            /*******************************************************
                Now To Swap Comp Cards  COMP AI
             *******************************************************/
            
            int compHandRank = [self getHandRank:self.compHand];
            
            if(compHandRank == 9){
                NSMutableArray *sortedCompHand = [self sortArrayHighToLow:self.compHand];
                int cardsSwapped = 0;
                for(int i = 2; i < 5; i++){
                    if( ((PGCard*)sortedCompHand[i]).cardIntValue < 9 && cardsSwapped <3 ){
                        [sortedCompHand replaceObjectAtIndex:i withObject: [self.myDeck getNextCard]];
                        cardsSwapped++;
                    }
                }
                self.compHand = sortedCompHand;
                [self updateComp2Cards];
            }
            /*********************************************************
                HERE COMP AI FINISHES
             ********************************************************/
            
        }
        if(self.callOnly == YES ){
            self.betButton.enabled = NO;
            self.testDisplayLabel.text = @"Please select CALL or FOLD.";
        }
        else{
            self.testDisplayLabel.text = @"Please select BET, CALL, or FOLD.";
        }
        self.finishedButton.enabled = NO;
        /*  **************************************************
                    Hand Pos 1 Ends
            **************************************************/
    }
    
    /*  ******************************************************
                    Hand Pos 2
        ******************************************************
    */
    else if (self.handPos == 2) {
        
        if(self.numCardsSelected < 4){
            
            self.playerHand = [self replaceCardsInPlayerHand];
            
            //  UPDATE THE PLAYER CARD IMAGEVIEWS
            [self updatePlayerCards];
            
            /*  *******************************************
             HERE START TESTING THE HANDS AND FIND A WINNER
             **********************************************/
            
            int playerHandRank = [self getHandRank:self.playerHand];
            int compHandRank = [self getHandRank: self.compHand];
            [self determineWinnerFromPlayer:playerHandRank andComp:compHandRank];
            
            if ( self.playerWins == YES ){
                self.testDisplayLabel.text = @" :) PLAYER WINS :) \nWhen you are ready to continue, press NEXT HAND.";
                [self.compC3 setImage:[UIImage imageNamed: [self.compHand[2] getCardStringValue]]];
                [self.compC4 setImage:[UIImage imageNamed: [self.compHand[3] getCardStringValue]]];
                [self.compC5 setImage:[UIImage imageNamed: [self.compHand[4] getCardStringValue]]];
                self.playerMonies = self.playerMonies + self.pot;
                self.pot = 0;
            }
            
            else if ( self.compWins == YES ){
                self.testDisplayLabel.text = @" ; ; COMP WINS ; ; \nWhen you are ready to continue, press NEXT HAND.";
                [self.compC3 setImage:[UIImage imageNamed: [self.compHand[2] getCardStringValue]]];
                [self.compC4 setImage:[UIImage imageNamed: [self.compHand[3] getCardStringValue]]];
                [self.compC5 setImage:[UIImage imageNamed: [self.compHand[4] getCardStringValue]]];
                self.compMonies = self.compMonies + self.pot;
                self.pot = 0;
            }
            
            else if ( self.tie == YES ){
                self.testDisplayLabel.text = @"----TIE----\nWhen you are ready to continue, press NEXT HAND.";
                [self.compC3 setImage:[UIImage imageNamed: [self.compHand[2] getCardStringValue]]];
                [self.compC4 setImage:[UIImage imageNamed: [self.compHand[3] getCardStringValue]]];
                [self.compC5 setImage:[UIImage imageNamed: [self.compHand[4] getCardStringValue]]];
                self.playerMonies = self.playerMonies + (int)(self.pot / 2);
                self.compMonies = self.compMonies + (int)(self.pot / 2);
                self.pot = 0;
                
            }
            
            if ( self.playerMonies <= 0 ){
                
                [self.finishedButton setTitle:@"NEW GAME" forState: UIControlStateNormal];
                //  Alert code
                UIAlertController *noMoneyAlert = [UIAlertController alertControllerWithTitle:@"GAME OVER - YOU LOSE" message:@"You have no more money and have lost the game. Better luck next time!"preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                //Handle your yes please button action here
                                            }];
                [noMoneyAlert addAction:yesButton];
                [self presentViewController:noMoneyAlert animated:YES completion:nil];
                //  Alert code finished.
                
                self.gameOver = YES;
                self.testDisplayLabel.text = @"YOU LOST. You are out of money. Press NEW GAME to play again, or hit Back in the navigation bar to exit.";
                self.myPlayer.losses++;
            }
            
            if ( self.compMonies <= 0 ){
                
                [self.finishedButton setTitle:@"NEW GAME" forState: UIControlStateNormal];
                
                UIAlertController *noMoneyAlert = [UIAlertController alertControllerWithTitle:@"GAME OVER - YOU WIN :)" message:@"You have won the game. Great Job!!!"preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                //Handle your yes please button action here
                                            }];
                [noMoneyAlert addAction:yesButton];
                [self presentViewController:noMoneyAlert animated:YES completion:nil];
                self.gameOver = YES;
                self.testDisplayLabel.text = @"YOU WON. Press NEW GAME to play again, or hit Back in the navigation bar to exit.";
                
                self.myPlayer.wins++;
            }
            
            
            if ( self.playerMonies == 1 || self.playerMonies == 2){
                self.callOnly = YES;
            }
            else {
                self.callOnly = NO;
            }

            self.isHandStart = YES;
            if ( self.gameOver == NO){
                [self.finishedButton setTitle:@"NEXT HAND" forState:UIControlStateNormal];
            }
        }
    }
    /*  **********************************************************************
                Hand Pos 2 Ends
        **********************************************************************/
    
    /*  **********************************************************************
                Shared Finish Button Code
        **********************************************************************/
    
    self.handPos++;
 
}


-(void)endGame{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}


/*  ***************************************************************************
    ***************************************************************************
                        REPLACE CARDS IN PLAYER HAND
    ***************************************************************************
    ***************************************************************************
*/

-(NSMutableArray*)replaceCardsInPlayerHand {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for(PGCard *card in self.playerHand){
        /*   Here all the selected cards get replaced with the next card in the deck.   */
        if(card.wasSelected){
            card.wasSelected = NO;
            [tempArray addObject: [self.myDeck getNextCard] ];
        }
        else{
            [tempArray addObject: card];
        }
    }
    return tempArray;
    
}

/*  ***************************************************************************
    ***************************************************************************
                            RESET FOR NEXT HAND
    ***************************************************************************
    ***************************************************************************
*/
 

-(void)resetForNextHand{
    
    [self.finishedButton setTitle:@"FINISHED" forState:UIControlStateNormal];
    self.isHandStart = NO;
    //  Get monies ready for hand
    [self takeMinBet];
    [self takeOneFromCompForPot];
    [self updateMonies];
    
    NSString *startMessage = @"If you would like to bet before swapping cards, press BET.";
    self.testDisplayLabel.text = startMessage;

    [self turnOffHighlightedBooleans];
    self.handPos = 0;
    
    //  Get new deck and shuffle cards
    self.myDeck = [PGDeck new];
    [self.myDeck shuffleDeck];
    self.playerHand = [NSMutableArray new];
    self.compHand = [NSMutableArray new];
    [self dealHandsFromMyDeck];
    [self turnOnBetCallFold];
    if(self.callOnly == YES){
        self.betButton.enabled = NO;
    }
    [self updateComp2Cards];
    [self updatePlayerCards];
    
    if( self.compFoldReset == YES){
        self.compFoldReset = NO;
    }
    self.finishedButton.enabled = NO;
    
}

/*  ***************************************************************************
    ***************************************************************************
                    BET BUTTON SELECTED
    ***************************************************************************
    ***************************************************************************
*/

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (IBAction)betSelected:(id)sender {
    
    /*      Here i'll turn off all the buttons so the user cant hit another one
            before the code fires off.
    */
    self.betButton.enabled = NO;
    self.callButton.enabled = NO;
    self.foldButton.enabled = NO;
    
//***************************ADDING AI BELOW HERE *****************
    
    
    int compHandRank = [self getHandRank:self.compHand];
    if (compHandRank < 9){
        self.compCall = YES;
    }
    
    if(self.myPlayer.compDifficulty == 1){
        self.compDiffLevel = 12;
    }
    else if (self.myPlayer.compDifficulty == 2){
        self.compDiffLevel = 10;
    }
    else{
        self.compDiffLevel = 8;
    }
    
    if (compHandRank == 9){
        NSMutableArray *sortedCompHand = [self sortArrayHighToLow:self.compHand];
        if( ((PGCard*)sortedCompHand[0]).cardIntValue > self.compDiffLevel ){
            self.compCall = YES;
        }
        else{
            self.compCall = NO;
        }
    }
    
    if(self.compMonies == 0){
        self.compCall = NO;
    }
    
    if ( self.compCall == YES){
        self.compMonies--;
        self.pot++;
        [self updateMonies];
    // below this is the bet code if comp calls.
    
//******************************************************************
    if(self.handPos == 1){ // This is first part of hand.
        
        if(self.playerMonies == 1){ // If the player is out of money with bet.
            
            UIAlertController *noMoneyAlert = [UIAlertController alertControllerWithTitle:@"NO MONEY" message:@"You have no more money, so you can only call. If you lose this hand, you're done!"preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                    NSLog(@"Ok action");
                }];
            
            [noMoneyAlert addAction:yesButton];
            [self presentViewController:noMoneyAlert animated:YES completion:nil];
             
            self.callOnly = YES;
            [self takeMinBet];
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
            [self turnOffHighlightedBooleans];
            self.pC1button.enabled = YES;
            self.pC2button.enabled = YES;
            self.pC3button.enabled = YES;
            self.pC4button.enabled = YES;
            self.pC5button.enabled = YES;
            self.numCardsSelected = 0;
        }
        
        else{
            [self takeMinBet];
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
            [self turnOffHighlightedBooleans];
            [self enableCards];
            self.numCardsSelected = 0;
        }
    }
    
    else if(self.handPos == 2){
        
        if(self.playerMonies == 1){
            [self enableCards];
            
            UIAlertController *noMoneyAlert = [UIAlertController alertControllerWithTitle:@"NO MONEY" message:@"You have no more money, so you can only call. If you lose this hand, you're done!"preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                            [noMoneyAlert dismissViewControllerAnimated:YES completion:nil];                                        }];
            [noMoneyAlert addAction:yesButton];
            [self presentViewController:noMoneyAlert animated:YES completion:nil];
            [self takeMinBet];
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
            
        }
        else{
            [self turnOffHighlightedBooleans];
            self.playerMonies--;
            self.pot++;
            [self updateMonies];
            [self enableCards];
            self.numCardsSelected = 0;
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
        }
    }
        
    
    /********************************************************************************
            Rest of AI Code
     *******************************************************************************/
    }
    else if ( self.compCall == NO && self.compMonies > 0) {
        
        /*
         Here i'll turn off all the buttons so the user cant hit another one
         before the code fires off.
         */
        
        self.betButton.enabled = NO;
        self.callButton.enabled = NO;
        self.foldButton.enabled = NO;
        self.isHandStart = YES;
        [self.finishedButton setTitle:@"NEXT HAND" forState:UIControlStateNormal];
        self.playerMonies = self.playerMonies + self.pot;
        self.pot = 0;
        [self updateMonies];
        
        if(self.isHandStart == YES){

            self.isHandStart = NO;
            [self.finishedButton setTitle:@"FINISHED" forState:UIControlStateNormal];
            [self resetForNextHand];
            self.testDisplayLabel.text = @"COMPUTER FOLDED! Click NEXT HAND to continue.";
            self.playerWins = NO;
            self.compWins = NO;
            self.tie = NO;
        }
        
        [self turnOnBetCallFold];
        self.compFoldReset = YES;
        
    }
    else if (self.compCall == NO && self.compMonies == 0){
        
        /************************************************************************
         Here, if player selects bet, and computer is out of money, then 
         the hand will continue till end without any bet from computer.
         Will pop up a message to let player know.
         ************************************************************************/
        
        if(self.playerMonies == 1){ // If the player is out of money with bet.
            
            //  Alert code.
            UIAlertController *noMoneyAlert = [UIAlertController alertControllerWithTitle:@"NO MONEY" message:@"You have no more money, so you can only call. If you lose this hand, you're done!"preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  NSLog(@"Ok action");
                                                              }];
            
            [noMoneyAlert addAction:yesButton];
            [self presentViewController:noMoneyAlert animated:YES completion:nil];
            
            // Alert code
            UIAlertController *compNoMoneyAlert = [UIAlertController alertControllerWithTitle:@"Computer has NO MONEY" message:@"Comp has no more money, so it will only call. Your bet is not being taken. If you win this hand, you're win the game!"preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesCompButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  NSLog(@"Ok action");
                                                              }];
            
            [compNoMoneyAlert addAction:yesCompButton];
            [self presentViewController:compNoMoneyAlert animated:YES completion:nil];
            //  Alert code ends
            
            self.callOnly = YES;
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
            [self turnOffHighlightedBooleans];
            [self enableCards];
            self.numCardsSelected = 0;
        }
        
        else{
            NSLog(@"First Hand bet Selected Entered.");
            //  Alert to let player know comp is out of money and will only call.
            UIAlertController *compNoMoneyAlert = [UIAlertController alertControllerWithTitle:@"Computer has NO MONEY" message:@"Comp has no more money, so it will only call. Your bet is not being taken. If you win this hand, you're win the game!"preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesCompButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      NSLog(@"Ok action");
                                                                  }];
            
            [compNoMoneyAlert addAction:yesCompButton];
            [self presentViewController:compNoMoneyAlert animated:YES completion:nil];
            //  End of alert code.
            
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
            [self turnOffHighlightedBooleans];
            [self enableCards];
            self.numCardsSelected = 0;
        }
        
    }
    self.finishedButton.enabled = YES;
}

/*  *********************************************************************************
    *********************************************************************************
                            CALL BUTTON SELECTED
    *********************************************************************************
    *********************************************************************************
*/

- (IBAction)callSelected:(id)sender {
    
    /*      Here i'll turn off all the buttons so the user cant hit another one
     before the code fires off.
     */
    self.betButton.enabled = NO;
    self.callButton.enabled = NO;
    self.foldButton.enabled = NO;
    [self turnOffHighlightedBooleans];
    
    if(self.handPos == 1){ // This is first part of hand.

            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
            [self turnOffHighlightedBooleans];
            self.pC1button.enabled = YES;
            self.pC2button.enabled = YES;
            self.pC3button.enabled = YES;
            self.pC4button.enabled = YES;
            self.pC5button.enabled = YES;
            self.numCardsSelected = 0;
    }
    
    else if(self.handPos == 2){
        
        if(self.playerMonies == 1){
            [self enableCards];
            // Use a alert controller to warn player they are in last hand.
            UIAlertController *noMoneyAlert = [UIAlertController alertControllerWithTitle:@"NEXT HAND IS YOUR LAST IF YOU LOSE" message:@"You will have no more money if you lose, and will only be able to call. If you lose this hand, you're next hand is your last chance!"preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                            [noMoneyAlert dismissViewControllerAnimated:YES completion:nil];                                        }];
            [noMoneyAlert addAction:yesButton];
            [self presentViewController:noMoneyAlert animated:YES completion:nil];
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
            
        }
        else{
            // Call Button in Second Hand.
            [self turnOffHighlightedBooleans];
            [self updateMonies];
            [self enableCards];
            /*self.pC1button.enabled = YES;
            self.pC2button.enabled = YES;
            self.pC3button.enabled = YES;
            self.pC4button.enabled = YES;
            self.pC5button.enabled = YES;*/
            self.numCardsSelected = 0;
            self.testDisplayLabel.text = @"Please select 0 to 3 cards to replace, then press Finished! button.";
        }
        
    }
    self.finishedButton.enabled = YES;
    
}

/*  *********************************************************************************
    *********************************************************************************
                            FOLD BUTTON
    *********************************************************************************
    *********************************************************************************
 */

- (IBAction)foldSelected:(id)sender {
    
    /*
     Here i'll turn off all the buttons so the user cant hit another one
     before the code fires off.
    */
    
    self.betButton.enabled = NO;
    self.callButton.enabled = NO;
    self.foldButton.enabled = NO;
    
    /*
        Here is where i need to add the code to to end a hand, and move on to 
        the next. It will need to test the players money, and see if they have 
        more than zero.
    */
    
    self.isHandStart = YES;
    self.compMonies = self.compMonies + self.pot;
    self.pot = 0;
    [self.finishedButton setTitle:@"NEXT HAND" forState:UIControlStateNormal];
    self.testDisplayLabel.text = @"You Folded. Press NEXT HAND to continue to next hand";
    [self turnOffBetCallFold];
    self.finishedButton.enabled = YES;
}


- (IBAction)previousSelected:(id)sender {
}


-(void)singleTapping:(UIGestureRecognizer *)recognizer{
    
    NSLog(@"Here is where the image tapping code would be placed.");
    
}


/*  *********************************************************************************
    *********************************************************************************
                            CARD BUTTONS
    *********************************************************************************
    *********************************************************************************
 */
- (IBAction)pressedPC1:(id)sender {
    
    if(self.numCardsSelected < 3){
        
        if (self.isHighlighted1 == NO){
            [self.playerC1 setAlpha: 0.42];
            self.isHighlighted1 = YES;
            ((PGCard*)self.playerHand[0]).wasSelected = YES;
            self.numCardsSelected++;
        }
        else{
            [self.playerC1 setAlpha:1.00];
            ((PGCard*)self.playerHand[0]).wasSelected = NO;
            self.isHighlighted1 = NO;
            self.numCardsSelected--;
        }
        
    }
    else if(self.numCardsSelected == 3){
        
        if(self.isHighlighted1 == YES){
            ((PGCard*)self.playerHand[0]).wasSelected = NO;
            [self.playerC1 setAlpha:1.00];
            self.isHighlighted1 = NO;
            self.numCardsSelected--;
        }
    }
    
}

- (IBAction)pressedPC2:(id)sender {
    
    if(self.numCardsSelected < 3){
        
        if (self.isHighlighted2 == NO){
            [self.playerC2 setAlpha: 0.42];
            ((PGCard*)self.playerHand[1]).wasSelected = YES;
            self.isHighlighted2 = YES;
            self.numCardsSelected++;
        }
        else{
            [self.playerC2 setAlpha:1.00];
            ((PGCard*)self.playerHand[1]).wasSelected = NO;
            self.isHighlighted2 = NO;
            self.numCardsSelected--;
        }
        
    }
    else if(self.numCardsSelected == 3){
        
        if(self.isHighlighted2 == YES){
            [self.playerC2 setAlpha:1.00];
            ((PGCard*)self.playerHand[1]).wasSelected = NO;
            self.isHighlighted2 = NO;
            self.numCardsSelected--;
        }
    }
    
}

- (IBAction)pressedPC3:(id)sender {
    
    if(self.numCardsSelected < 3){
        
        if (self.isHighlighted3 == NO){
            [self.playerC3 setAlpha: 0.42];
            ((PGCard*)self.playerHand[2]).wasSelected = YES;
            self.isHighlighted3 = YES;
            self.numCardsSelected++;
        }
        else{
            [self.playerC3 setAlpha:1.00];
            ((PGCard*)self.playerHand[2]).wasSelected = NO;
            self.isHighlighted3 = NO;
            self.numCardsSelected--;
        }
        
    }
    else if(self.numCardsSelected == 3){
        
        if(self.isHighlighted3 == YES){
            [self.playerC5 setAlpha:1.00];
            ((PGCard*)self.playerHand[2]).wasSelected = NO;
            self.isHighlighted3 = NO;
            self.numCardsSelected--;
        }
    }
    
}

- (IBAction)pressedPC4:(id)sender {
    
    if(self.numCardsSelected < 3){
        
        if (self.isHighlighted4 == NO){
            [self.playerC4 setAlpha: 0.42];
            ((PGCard*)self.playerHand[3]).wasSelected = YES;
            self.isHighlighted4 = YES;
            self.numCardsSelected++;
        }
        else{
            [self.playerC4 setAlpha:1.00];
            ((PGCard*)self.playerHand[3]).wasSelected = NO;
            self.isHighlighted4 = NO;
            self.numCardsSelected--;
        }
        
    }
    else if(self.numCardsSelected == 3){
        
        if(self.isHighlighted4 == YES){
            [self.playerC4 setAlpha:1.00];
            ((PGCard*)self.playerHand[3]).wasSelected = NO;
            self.isHighlighted4 = NO;
            self.numCardsSelected--;
        }
    }
    
}

- (IBAction)pressedPC5:(id)sender {
    
    if(self.numCardsSelected < 3){
        
        if (self.isHighlighted5 == NO){
            [self.playerC5 setAlpha: 0.42];
            ((PGCard*)self.playerHand[4]).wasSelected = YES;
            self.isHighlighted5 = YES;
            self.numCardsSelected++;
        }
        else{
            [self.playerC5 setAlpha:1.00];
            ((PGCard*)self.playerHand[4]).wasSelected = NO;
            self.isHighlighted5 = NO;
            self.numCardsSelected--;
        }
        
    }
    else if(self.numCardsSelected == 3){
        
        if(self.isHighlighted5 == YES){
            [self.playerC5 setAlpha:1.00];
            ((PGCard*)self.playerHand[4]).wasSelected = NO;
            self.isHighlighted5 = NO;
            self.numCardsSelected--;
        }
    }
    
}

/*  *********************************************************************************
    *********************************************************************************
                        UPDATE METHODS
    *********************************************************************************
    *********************************************************************************
 */

-(void)takeOneFromCompForPot{
    self.compMonies--;
    self.pot++;
}

-(void)turnOffBetCallFold{
    
    self.betButton.enabled = NO;
    self.callButton.enabled = NO;
    self.foldButton.enabled = NO;
    
}

-(void)turnOnBetCallFold{
    
    self.betButton.enabled = YES;
    self.callButton.enabled = YES;
    self.foldButton.enabled = YES;
}

-(void)takePlayer2Bet{
    self.playerMonies -=2;
    self.pot+=2;
    [self updateMonies];
}

-(void)takeMinBet{
    self.playerMonies--;
    self.pot++;
    [self updateMonies];
}


-(void)updatePlayerCards{
    
    [self.playerC1 setImage: [UIImage imageNamed:[self.playerHand[0] getCardStringValue]]];
    [self.playerC1 setAlpha:1.00];
    [self.playerC2 setImage: [UIImage imageNamed:[self.playerHand[1] getCardStringValue]]];
    [self.playerC2 setAlpha:1.00];
    [self.playerC3 setImage: [UIImage imageNamed:[self.playerHand[2] getCardStringValue]]];
    [self.playerC3 setAlpha:1.00];
    [self.playerC4 setImage: [UIImage imageNamed:[self.playerHand[3] getCardStringValue]]];
    [self.playerC4 setAlpha:1.00];
    [self.playerC5 setImage: [UIImage imageNamed:[self.playerHand[4] getCardStringValue]]];
    [self.playerC5 setAlpha:1.00];
    
}

-(void)updateMonies{
    self.potLabel.text = [NSString stringWithFormat:@"Pot: $%i", self.pot];
    self.playerMoniesLabel.text = [NSString stringWithFormat:@"Player: $%i", self.playerMonies];
    self.compMoneyLabel.text = [NSString stringWithFormat:@"Comp: $%i", self.compMonies];
}

-(void)disableCards{
    
    self.pC1button.enabled = NO;
    self.pC2button.enabled = NO;
    self.pC3button.enabled = NO;
    self.pC4button.enabled = NO;
    self.pC5button.enabled = NO;

}

-(void)turnOffHighlightedBooleans{
    
    self.isHighlighted1 = NO;
    self.isHighlighted2 = NO;
    self.isHighlighted3 = NO;
    self.isHighlighted4 = NO;
    self.isHighlighted5 = NO;
    
}


-(void)dealHandsFromMyDeck{
    
    for(int i = 0; i < 10; i++){
        if( i % 2 == 0){
            ((PGCard *)self.myDeck.cardDeckArr[i]).alreadyDealt = YES;
            [self.playerHand addObject: [self.myDeck.cardDeckArr objectAtIndex:i]];
            self.myDeck.index++;
        }
        else{
            ((PGCard *)self.myDeck.cardDeckArr[i]).alreadyDealt = YES;
            [self.compHand addObject: [self.myDeck.cardDeckArr objectAtIndex:i]];
            self.myDeck.index++;
        }
    }
}

-(void)enableCards{
    self.pC1button.enabled = YES;
    self.pC2button.enabled = YES;
    self.pC3button.enabled = YES;
    self.pC4button.enabled = YES;
    self.pC5button.enabled = YES;
}

-(void)updateComp2Cards{
    
    [self.compC1 setImage: [UIImage imageNamed: [self.compHand[0] getCardStringValue]]];
    [self.compC2 setImage: [UIImage imageNamed: [self.compHand[1] getCardStringValue]]];
    [self.compC3 setImage: [UIImage imageNamed: @"card_backside_blue.png"]];
    [self.compC4 setImage: [UIImage imageNamed: @"card_backside_blue.png"]];
    [self.compC5 setImage: [UIImage imageNamed: @"card_backside_blue.png"]];
}

/*  ******************************************************************
    ******************************************************************
            GET HAND RANK
    ******************************************************************
    *****************************************************************
*/


-(int)getHandRank: (NSMutableArray *) hand {
    
    /*
        Each time hand rank is changed, the values it 
        uses need to get reset.
    */
    int rank = 0;
    self.fourKind = NO;
    self.threeKind = NO;
    self.fullHouse = NO;
    self.twoPair = NO;
    self.pair = NO;
    self.highCard = NO;
    self.flush = NO;
    self.straight = NO;
   
    NSMutableArray *rankArray = [NSMutableArray array];
    rankArray = [self getRankArrayForHand:hand];
    /*
    for (int i = 0; i < 13; i++ ){
        [rankArray addObject: @0];
    }
    //  Now I'm filling my buckets to see what cards are in the hand.
    for (int i = 0; i < 5; i++){
        
        PGCard *card = hand[i];
        int intVal = card.cardIntValue;
        int indx = intVal - 2;
        NSNumber *arrObj= [rankArray objectAtIndex: indx];
        int arrayObject = [arrObj intValue];
        arrayObject++;
        NSNumber *insertNum = [NSNumber numberWithInt:arrayObject];
        [rankArray replaceObjectAtIndex: indx withObject: insertNum];
    }
     
     */
    
    for( int i = 0; i < 13; i++ ){
        
        NSNumber *arrObj = [rankArray objectAtIndex: i];
        int arrayObject = [arrObj intValue];
        //  CHECK FOR FOUR OF A KIND
        if( arrayObject == 4 ){
            self.fourKind = YES;
            rank = 2;
            goto outloop;
        }
        //  CHECK FOR FULL HOUSE
        if( arrayObject == 3 ){
            for( int j = 0; j < 13; j++ ){
                
                NSNumber *arrObj2 = [rankArray objectAtIndex: j];
                int arrayObject2 = [arrObj2 intValue];
                if ( arrayObject2 == 2 ){
                    self.fullHouse = YES;
                    rank = 3;
                    goto  outloop;
                }
            }
            //  THREE OF A KIND
            self.threeKind = YES;
            rank = 6;

            goto outloop;
        }
        //  CHECK FOR TWO PAIR
        if ( arrayObject ==2 ){
            for(int k = (i+1); k < 13; k++){
                NSNumber *arrObj3 = [rankArray objectAtIndex: k];
                int arrayObject3 = [arrObj3 intValue];
                if( arrayObject3 == 2 ){
                    self.twoPair = YES;
                    rank = 7;
                    goto outloop;
                }
            }
            self.pair = YES;
            //  AND HERE IS A PAIR WITH LOW CARDS
            rank = 8;
            goto outloop;
        }
    }outloop:;
    
    int numSameSuit = 0;
    SUIT aSuit = ((PGCard*)hand[0]).cardSuit;
        
    for(int l = 1; l < 5; l++){
        if ( aSuit == ((PGCard*)hand[l]).cardSuit ){
            numSameSuit++;
        }
    }
        
    if( numSameSuit == 4 ){
        self.flush = YES;
        rank = 4;
    }
    NSMutableArray *sortedArray = [self sortArrayHighToLow: hand];
    
    int most = ((PGCard*)sortedArray[0]).cardIntValue;
    int least = ((PGCard*)sortedArray[4]).cardIntValue;
    
    if( rank != 2 && rank != 3 && rank != 6 && rank != 7 && rank != 8){
        if(most-least == 4){
            self.straight = YES;
            rank = 5;
        }
    }
    if( self.flush == YES && self.straight == YES){
        self.straightFlush = YES;
        rank = 1;
        self.straight = NO;
        self.flush = NO;
    }
    if ( rank == 0 ){
        rank = 9;
    }
    return rank;
}

-(NSMutableArray *)sortArrayHighToLow: (NSMutableArray*) arr {
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"cardIntValue" ascending:NO];
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    NSArray *temp = [arr sortedArrayUsingDescriptors:sortDescriptors];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray: temp];
    return sortedArray;
}

/*  *********************************************************************************
    *********************************************************************************
                        DETERMINE WINNER FUNCTION
    *********************************************************************************
    *********************************************************************************
*/

-(void)determineWinnerFromPlayer: (int) p andComp: (int) c {
    
    NSLog(@"Player Hand Rank: %d \nCompHand Rank: %d", p, c);
    
    if ( p < c ) {
        self.playerWins = YES;
    }
    else if (c < p ) {
        self.compWins = YES;
    }
    else if ( p == c ) {
   
        /*  ************************************************************************
                TESTING FOR STRAIGHT, FLUSH, STRAIGHT FLUSH,
                AND HIGH CARD
            ************************************************************************
        */
        
        if ( p == 1 || p == 4 || p == 5 || p == 9) {
            
            NSMutableArray *playerSorted = [self sortArrayHighToLow:self.playerHand];
            NSMutableArray *compSorted = [self sortArrayHighToLow: self.compHand];
        
            for ( int i = 0; i < 5; i++){
                if ( ((PGCard*)playerSorted[i]).cardIntValue > ((PGCard*)compSorted[i]).cardIntValue ){
                    self.playerWins = YES;
                    goto outer;
                }
                else if( ((PGCard*)playerSorted[i]).cardIntValue < ((PGCard*)compSorted[i]).cardIntValue ) {
                    self.compWins = YES;
                    goto outer;
                }
            }
            
            if (self.playerWins != YES && self.compWins != YES){
                self.tie = YES;
                goto outer;
            }
            
        }outer:;
        
        /*  **************************************************************
                TESTING FOR 4 OF A KIND
            **************************************************************
        */
        
        if ( p == 2){
            /*
                This works because once the hands are sorted, since we know they are 4 of a kind, then
                the middle value is the paired value, and the low card is determined and checked.
            */
           
            NSMutableArray *playerSorted2 = [self sortArrayHighToLow:self.playerHand];
            NSMutableArray *compSorted2 = [self sortArrayHighToLow: self.compHand];
            
            int checkValPlayer = ((PGCard*)playerSorted2[2]).cardIntValue;
            int checkValComp = ((PGCard*)compSorted2[2]).cardIntValue;
          
            
            if (checkValPlayer > checkValComp ) {
                self.playerWins = YES;
            }
            else if (checkValComp > checkValPlayer){
                self.compWins = YES;
            }
            else if (checkValComp == checkValPlayer){
                int playerLowCard;
                int compLowCard;
                
                if ( checkValPlayer == ((PGCard*)playerSorted2[0]).cardIntValue){
                   playerLowCard = ((PGCard*)playerSorted2[4]).cardIntValue;
                }
                else if ( checkValPlayer == ((PGCard*)playerSorted2[4]).cardIntValue ){
                    playerLowCard = ((PGCard*)playerSorted2[0]).cardIntValue;
                }
                
                if ( checkValComp == ((PGCard*)compSorted2[0]).cardIntValue){
                    compLowCard = ((PGCard*)compSorted2[4]).cardIntValue;
                }
                else if ( checkValPlayer == ((PGCard*)playerSorted2[4]).cardIntValue ){
                    compLowCard = ((PGCard*)compSorted2[0]).cardIntValue;
                }
                
                if(playerLowCard > compLowCard){
                    self.playerWins = YES;
                }
                else if (compLowCard > playerLowCard) {
                    self.compWins = YES;
                }
                else if (compLowCard == playerLowCard){
                    self.tie = YES;
                }
                
            }
            
        }
        
        /*  ******************************************************************
                    TESTING FOR FULL HOUSE
            ******************************************************************
        */
        
        if ( p == 3 ){
            
            /*  
                Here this works alot like 4 of a kind, on the idea that the middle 
                card will be part of the trio once the cards are sorted by int value.
                We then use that card to find the value of the pair, and compare those.
            */
            
            NSMutableArray *playerSorted2 = [self sortArrayHighToLow:self.playerHand];
            NSMutableArray *compSorted2 = [self sortArrayHighToLow: self.compHand];
            
            int checkValPlayer = ((PGCard*)playerSorted2[2]).cardIntValue;
            int checkValComp = ((PGCard*)compSorted2[2]).cardIntValue;
            
            
            if (checkValPlayer > checkValComp ) {
                self.playerWins = YES;
            }
            else if (checkValComp > checkValPlayer){
                self.compWins = YES;
            }
            else if (checkValComp == checkValPlayer){
                
                int playerLowCard;
                int compLowCard;
                
                if ( checkValPlayer == ((PGCard*)playerSorted2[0]).cardIntValue){
                    playerLowCard = ((PGCard*)playerSorted2[4]).cardIntValue;
                }
                else if ( checkValPlayer == ((PGCard*)playerSorted2[4]).cardIntValue ){
                    playerLowCard = ((PGCard*)playerSorted2[0]).cardIntValue;
                }
                
                if ( checkValComp == ((PGCard*)compSorted2[0]).cardIntValue){
                    compLowCard = ((PGCard*)compSorted2[4]).cardIntValue;
                }
                else if ( checkValPlayer == ((PGCard*)playerSorted2[4]).cardIntValue ){
                    compLowCard = ((PGCard*)compSorted2[0]).cardIntValue;
                }
                
                if(playerLowCard > compLowCard){
                    self.playerWins = YES;
                }
                else if (compLowCard > playerLowCard) {
                    self.compWins = YES;
                }
                else if (compLowCard == playerLowCard){
                    self.tie = YES;
                }
            }
        }
        
        /*  *************************************************************************
                HERE I CHECK THREE OF A KIND TIE FOR A WINNER
            *************************************************************************
        */
        
        if  ( p == 6 ){
            
            
            NSMutableArray *playerSorted2 = [self sortArrayHighToLow:self.playerHand];
            NSMutableArray *compSorted2 = [self sortArrayHighToLow: self.compHand];
            
            int checkValPlayer = ((PGCard*)playerSorted2[2]).cardIntValue;
            int checkValComp = ((PGCard*)compSorted2[2]).cardIntValue;
            
            
            if (checkValPlayer > checkValComp ) {
                self.playerWins = YES;
            }
            else if (checkValComp > checkValPlayer){
                self.compWins = YES;
            }
            else if (checkValComp == checkValPlayer){
                
                int player2ndLowCard= 0;
                int comp2ndLowCard = 0;
                int playerLowCard = 0;
                int compLowCard = 0;
                
                if ( ((PGCard*)playerSorted2[0]).cardIntValue == ((PGCard*)playerSorted2[1]).cardIntValue && ((PGCard*)playerSorted2[1]).cardIntValue == ((PGCard*)playerSorted2[2]).cardIntValue ){
                    
                    player2ndLowCard = ((PGCard*)playerSorted2[3]).cardIntValue;
                    playerLowCard = ((PGCard*)playerSorted2[4]).cardIntValue;
                }
                else if ( ((PGCard*)playerSorted2[1]).cardIntValue == ((PGCard*)playerSorted2[2]).cardIntValue && ((PGCard*)playerSorted2[2]).cardIntValue == ((PGCard*)playerSorted2[3]).cardIntValue ){
                    
                    player2ndLowCard = ((PGCard*)playerSorted2[0]).cardIntValue;
                    playerLowCard = ((PGCard*)playerSorted2[4]).cardIntValue;
                    
                }
                else if ( ((PGCard*)playerSorted2[2]).cardIntValue == ((PGCard*)playerSorted2[3]).cardIntValue && ((PGCard*)playerSorted2[3]).cardIntValue == ((PGCard*)playerSorted2[4]).cardIntValue ){
                    
                    player2ndLowCard = ((PGCard*)playerSorted2[0]).cardIntValue;
                    playerLowCard = ((PGCard*)playerSorted2[1]).cardIntValue;
                }
                
                
                if ( ((PGCard*)compSorted2[0]).cardIntValue == ((PGCard*)compSorted2[1]).cardIntValue && ((PGCard*)compSorted2[1]).cardIntValue == ((PGCard*)compSorted2[2]).cardIntValue ){
                    
                    comp2ndLowCard = ((PGCard*)compSorted2[3]).cardIntValue;
                    compLowCard = ((PGCard*)compSorted2[4]).cardIntValue;
                }
                else if ( ((PGCard*)compSorted2[1]).cardIntValue == ((PGCard*)compSorted2[2]).cardIntValue && ((PGCard*)compSorted2[2]).cardIntValue == ((PGCard*)compSorted2[3]).cardIntValue ){
                    
                    comp2ndLowCard = ((PGCard*)compSorted2[0]).cardIntValue;
                    compLowCard = ((PGCard*)compSorted2[4]).cardIntValue;
                    
                }
                else if ( ((PGCard*)compSorted2[2]).cardIntValue == ((PGCard*)compSorted2[3]).cardIntValue && ((PGCard*)compSorted2[3]).cardIntValue == ((PGCard*)compSorted2[4]).cardIntValue ){
                    
                    comp2ndLowCard = ((PGCard*)compSorted2[0]).cardIntValue;
                    compLowCard = ((PGCard*)compSorted2[1]).cardIntValue;
                }
                
                if ( player2ndLowCard > comp2ndLowCard){
                    self.playerWins = YES;
                }
                else if ( comp2ndLowCard > player2ndLowCard ){
                    self.compWins = YES;
                }
                else if ( comp2ndLowCard == player2ndLowCard ){
                    
                    if ( playerLowCard > compLowCard ){
                        self.playerWins = YES;
                    }
                    else if ( compLowCard > playerLowCard ){
                        self.compWins = YES;
                    }
                    else if ( compLowCard == playerLowCard ){
                        self.tie = YES;
                    }
                }
            }
        }
        
        
        
        /*  ******************************************************************
                            HERE I TEST TWO PAIRS
            ******************************************************************
        */
        
        
        if ( p == 7){
            
            /*
                HERE I FILL BUCKETS TO FIND THE PAIRS AND THE LONE CARD AND THEIR VALUES
            */
            
            NSMutableArray *rankArrayPlayer = [NSMutableArray array];
            rankArrayPlayer = [self getRankArrayForHand:self.playerHand];
            /*
            
            for (int i = 0; i < 13; i++ ){
                [rankArrayPlayer addObject:@(0)];
            }
            
            for (int i = 0; i < 5; i++){
                
                PGCard *card = self.playerHand[i];
                int intVal = card.cardIntValue;
                int indx = intVal - 2;
                NSNumber *arrObj= [rankArrayPlayer objectAtIndex: indx];
                int arrayObject = [arrObj intValue];
                arrayObject++;
                NSNumber *insertNum = [NSNumber numberWithInt:arrayObject];
                [rankArrayPlayer replaceObjectAtIndex: indx withObject: insertNum];
            }
            */
            
            NSMutableArray *rankArrayComp = [NSMutableArray array];
            rankArrayComp = [self getRankArrayForHand:self.compHand];
            /*
            for (int i = 0; i < 13; i++ ){
                [rankArrayComp addObject:@(0)];
            }
            for (int i = 0; i < 5; i++){
                
                PGCard *card = self.compHand[i];
                int intVal = card.cardIntValue;
                int indx = intVal - 2;
                NSNumber *arrObj= [rankArrayComp objectAtIndex: indx];
                int arrayObject = [arrObj intValue];
                arrayObject++;
                NSNumber *insertNum = [NSNumber numberWithInt:arrayObject];
                [rankArrayComp replaceObjectAtIndex: indx withObject: insertNum];
            }
            */
            
            
            
            /*
                    Now i have my buckets filled. Now to see which ones have 2's 
                    in them and rank them, and then find the single card.
            */
            
            Boolean foundFirstPair = NO;
            int playerFirstPairValue = 0;
            int playerSecondPairValue = 0;
            int compFirstPairValue = 0;
            int compSecondPairValue = 0;
            int playerLowCard = 0;
            int compLowCard = 0;
            
            for (int i = 0; i < 13; i++){
        
                if ( ((NSNumber*)rankArrayPlayer[i]).integerValue == 2){
                    if ( foundFirstPair == NO ){
                        playerSecondPairValue = i + 2;
                    }
                    else if ( foundFirstPair == YES){
                        playerFirstPairValue = i + 2;
                    }
                }
                else if (((NSNumber*)rankArrayPlayer[i]).integerValue == 1){
                    playerLowCard = i +2;
                }
            }
            
            foundFirstPair = NO;
            
            
            for (int i = 0; i < 13; i++){
                
                if ( ((NSNumber*)rankArrayComp[i]).integerValue == 2){
                    if ( foundFirstPair == NO ){
                        compSecondPairValue = i + 2;
                    }
                    else if ( foundFirstPair == YES){
                        compFirstPairValue = i + 2;
                    }
                }
                else if (((NSNumber*)rankArrayComp[i]).integerValue == 1){
                    compLowCard = i +2;
                }
            }

            /*
                Now I have my values, now to check them.  
            */
            
            if ( playerFirstPairValue > compFirstPairValue ){
                self.playerWins = YES;
            }
            else if ( compFirstPairValue > playerFirstPairValue ){
                self.compWins = YES;
            }
            else if ( playerFirstPairValue == compFirstPairValue ){
                
                if ( playerSecondPairValue > compSecondPairValue ){
                    self.playerWins = YES;
                }
                else if ( compSecondPairValue > playerSecondPairValue ){
                    self.compWins = YES;
                }
                else if ( playerSecondPairValue == compSecondPairValue ){
                    
                    if ( playerLowCard > compLowCard ){
                        self.playerWins = YES;
                    }
                    else if ( compLowCard > playerLowCard ){
                        self.compWins = YES;
                    }
                    else if ( playerLowCard == compLowCard ){
                        self.tie = YES;
                    }
                }
            }
        }
        
        /*  ******************************************************************
                            TESTING PAIRS FOR WINNER
            ******************************************************************
        */
        
        if ( p == 8 ){
           
            /************************************************************
             HERE I FILL BUCKETS TO FIND THE PAIRS AND THE LONE CARD AND 
             THEIR VALUES
             *************************************************************/
            NSMutableArray *rankArrayPlayer = [NSMutableArray array];
            rankArrayPlayer = [self getRankArrayForHand: self.playerHand];
            
            /*
            for (int i = 0; i < 13; i++ ){
                [rankArrayPlayer addObject:@(0)];
            }
            
            for (int i = 0; i < 5; i++){
                
                PGCard *card = self.playerHand[i];
                int intVal = card.cardIntValue;
                int indx = intVal - 2;
                NSNumber *arrObj= [rankArrayPlayer objectAtIndex: indx];
                int arrayObject = [arrObj intValue];
                arrayObject++;
                NSNumber *insertNum = [NSNumber numberWithInt:arrayObject];
                [rankArrayPlayer replaceObjectAtIndex: indx withObject: insertNum];
                
            }*/
            
            NSMutableArray *rankArrayComp = [NSMutableArray array];
            rankArrayComp = [self getRankArrayForHand: self.compHand];
            /*
            for (int i = 0; i < 13; i++ ){
                [rankArrayComp addObject:@(0)];
            }
      
            for (int i = 0; i < 5; i++){
                
                PGCard *card = self.compHand[i];
                int intVal = card.cardIntValue;
                int indx = intVal - 2;
                NSNumber *arrObj= [rankArrayComp objectAtIndex: indx];
                int arrayObject = [arrObj intValue];
                arrayObject++;
                NSNumber *insertNum = [NSNumber numberWithInt:arrayObject];
                [rankArrayComp replaceObjectAtIndex: indx withObject: insertNum];
                
            }
            */
            int playerPairValue = 0;
            int compPairValue = 0;
            int player3rdLow = 0;
            int comp3rdLow = 0;
            int player2ndLow = 0;
            int comp2ndLow = 0;
            int playerLow = 0;
            int compLow = 0;
            Boolean playerLowFound = NO;
            Boolean player2ndLowFound = NO;
            Boolean player3rdLowFound = NO;
            Boolean compLowFound = NO;
            Boolean comp2ndLowFound = NO;
            Boolean comp3rdLowFound = NO;
            
            /*****************
                PLAYER CHECK
            *****************/
            
            for (int i = 0; i < 13; i++){
                
                if ( ((NSNumber*)rankArrayPlayer[i]).integerValue == 2){
                        playerPairValue = i + 2;
                    NSLog(@"Player Pair Val: %d", playerPairValue);
                }
                
                else if ( ((NSNumber*)rankArrayPlayer[i]).integerValue == 1 ){
                    
                    if ( playerLowFound == NO ){
                        playerLow = i + 2;
                        NSLog(@"Player low: %d",playerLow);
                        playerLowFound = YES;
                    }
                    else if ( player2ndLowFound == NO){
                        player2ndLow = i + 2;
                        NSLog(@"Player 2ndlow: %d",player2ndLow);
                        player2ndLowFound = YES;
                    }
                    else if ( player3rdLowFound == NO){
                        player3rdLow = i + 2;
                        NSLog(@"Player 3rdlow: %d",player3rdLow);
                        player3rdLowFound = YES;
                    }
                }
            }
            /*************
                NOW COMP
            **************/
                
            for ( int i = 0; i < 13; i++ ){
                if ( ((NSNumber*)rankArrayComp[i]).integerValue == 2){
                    compPairValue = i + 2;
                    NSLog(@"Comp Pair Val: %d", compPairValue);
                }
                else if ( ((NSNumber*)rankArrayComp[i]).integerValue == 1 ){
                        
                    if ( compLowFound == NO ){
                        compLow = i + 2;
                        NSLog(@"Comp low: %d", compLow);
                        compLowFound = YES;
                    }
                    else if ( comp2ndLowFound == NO){
                        comp2ndLow = i + 2;
                        NSLog(@"Comp 2nd Low: %d",comp2ndLow);
                        comp3rdLowFound = YES;
                    }
                    else if ( comp3rdLowFound == NO){
                        comp3rdLow = i + 2;
                        NSLog(@"Comp 3rd Low: %d", comp3rdLow);
                        comp3rdLowFound = YES;
                    }
                }
            }
            
            NSLog(@"Final Player Pair Val: %d ", playerPairValue);
            NSLog(@"Final Comp Pair Val: %d", compPairValue);
            
            if( playerPairValue > compPairValue){
                self.playerWins = YES;
            }
            else if ( playerPairValue < compPairValue){
                self.compWins = YES;
            }
            else if ( playerPairValue == compPairValue ){
                if( player3rdLow > comp3rdLow){
                    self.playerWins = YES;
                }
                else if( player3rdLow < comp3rdLow ){
                    self.compWins = YES;
                }
                else if ( player3rdLow == comp3rdLow ){
                
                    if( player2ndLow > comp2ndLow){
                        self.playerWins = YES;
                    }
                    else if( player2ndLow < comp2ndLow ){
                        self.compWins = YES;
                    }
                    else if ( player2ndLow == comp2ndLow ){
                    
                        if( playerLow > compLow){
                            self.playerWins = YES;
                        }
                        else if( playerLow < compLow ){
                            self.compWins = YES;
                        }
                        else if ( playerLow == compLow ){
                            self.tie = YES;
                        }
                    }
                }
            }
            
            
        }
    }
}

/*****************************************************************************
    THIS RETURNS AN ARRAY THAT WILL BE USED TO DETERMINE HAND RAND
 *****************************************************************************/

-(NSMutableArray*)getRankArrayForHand: (NSMutableArray*)hand{
    
    NSMutableArray *rankArray = [NSMutableArray array];
    
    for (int i = 0; i < 13; i++ ){
        [rankArray addObject: @0];
    }
    //  Now I'm filling my buckets to see what cards are in the hand.
    for (int i = 0; i < 5; i++){
        
        PGCard *card = hand[i];
        int intVal = card.cardIntValue;
        int indx = intVal - 2;
        NSNumber *arrObj= [rankArray objectAtIndex: indx];
        int arrayObject = [arrObj intValue];
        arrayObject++;
        NSNumber *insertNum = [NSNumber numberWithInt:arrayObject];
        [rankArray replaceObjectAtIndex: indx withObject: insertNum];
    }
    return rankArray;
}

@end

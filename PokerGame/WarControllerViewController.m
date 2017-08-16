//
//  WarControllerViewController.m
//  PokerGame
//
//  Created by James Steimel on 8/2/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "WarControllerViewController.h"

@interface WarControllerViewController ()

@end

@implementation WarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstHand = YES;
    self.myPlayer = [CardPlayer sharedPlayer];
    self.myDeck = [[PGDeck alloc]init];
    
    //  these hold the player and computer hands
    self.playerHand = [NSMutableArray array];
    self.compHand = [NSMutableArray array];
    [self.myDeck shuffleDeck];
    [self splitTheDeck];
    self.potHand = [NSMutableArray array];
    _warTime = NO;
    
    /*
     Create a UIImageView.      */
    UIImage *backgroundImage = [UIImage imageNamed:@"perlinfelt1.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    /*
     This is so i can add some action (maybe an alert) to the
     player icon on the game screen.
     */
    [self.playerIconImage setImage:[UIImage imageNamed:self.myPlayer.iconPath]];
    [self.playerIconImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.playerIconImage addGestureRecognizer:singleTap];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.myPlayer.firstName, self.myPlayer.lastName];
    self.recordLabel.text = [NSString stringWithFormat: @"W: %d  L: %d", self.myPlayer.wins, self.myPlayer.losses];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)singleTapping:(UIGestureRecognizer *)recognizer{
    
    NSLog(@"Here is where the image tapping code would be placed.");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/************************************
    THESE BUTTONS WERE IN CASE
    I WANTED TO CHANGE THE ACTION
    TO THE CARDS THEMSELVES
 ************************************/

- (IBAction)pressedPC1:(id)sender {
}
- (IBAction)pressedPC2:(id)sender {
}
- (IBAction)pressedPC3:(id)sender {
}
- (IBAction)pressedPC4:(id)sender {
}
- (IBAction)pressedPC5:(id)sender {
}
- (IBAction)pressedCC1:(id)sender {
}
- (IBAction)pressedCC2:(id)sender {
}
- (IBAction)pressedCC3:(id)sender {
}
- (IBAction)pressedCC4:(id)sender {
}
- (IBAction)pressedCC5:(id)sender {
}

/***************************************************
    This method returns the last card in a hand
    and removes it from the hand and places it in 
    the pot.
****************************************************/

-(PGCard*)getACard: (NSMutableArray *)hand{

    PGCard* retCard = [PGCard new];
    retCard = [hand lastObject];
    [hand removeLastObject];
    [_potHand addObject: retCard];
    return retCard;
}

/***************************************************
    This method is used to prepare for a new game.
****************************************************/

-(void)resetTheGame{
    
    self.myDeck = [[PGDeck alloc]init];
    //  these hold the player and computer hands
    self.playerHand = [NSMutableArray array];
    self.compHand = [NSMutableArray array];
    [self.myDeck shuffleDeck];
    [self splitTheDeck];
    self.potHand = [NSMutableArray array];
    _warTime = NO;

}

/***************************************************************
    This method add the cards in the pot to the hand
****************************************************************/

-(void)addPotToHand:(NSMutableArray*)hand{
    
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                           NSMakeRange(0,[_potHand count])];
    [hand insertObjects:_potHand atIndexes:indexes];
}

/****************************************************************
 ****************************************************************
                        PRESSED NEXT CARD
    This is the main method of the program and handles all user
    input.
*****************************************************************
 ****************************************************************/

- (IBAction)pressedNextCard:(id)sender {
    
    if( _needAReset == YES ){
        [self resetTheGame];
    }
    
    if(_leavingWar == YES){
        _leavingWar = NO;
    }
    
    if ( _warTime == YES ){
        
        [self makeCardsVisable];
        int playerMax = 0;
        int compMax = 0;
        /**************************************************
         If either have counts below 4
         ***************************************************/
        if( _playerHand.count < 4 || _compHand.count < 4 ){
            /***********************************************
             player < 4
             **********************************************/
            if(_playerHand.count < 4){
                NSInteger temp = _playerHand.count;
                int count = (int)temp;
                
                if(count == 1){
                    PGCard *card1 = [self getACard:_playerHand];
                    [self.imagePC2 setImage: card1.img];
                    playerMax = card1.cardIntValue;
                }
                else if (count == 2){
                    PGCard *card1 = [self getACard:_playerHand];
                    PGCard *card2 = [self getACard:_playerHand];
                    [self.imagePC2 setImage: card1.img];
                    [self.imagePC3 setImage: card2.img];
                    playerMax = card2.cardIntValue;
                }
                else if (count == 3){
                    PGCard *card1 = [self getACard:_playerHand];
                    PGCard *card2 = [self getACard:_playerHand];
                    PGCard *card3 = [self getACard:_playerHand];
                    [self.imagePC2 setImage: card1.img];
                    [self.imagePC3 setImage: card2.img];
                    [self.imagePC4 setImage: card3.img];
                    playerMax = card3.cardIntValue;
                }
                /*********************************
                 comp < 4 in player < 4
                 ***********************************/
                
                if(_compHand.count < 4){
                    int count = (int)_compHand.count;
                    
                    if(count == 1){
                        PGCard *card1 = [self getACard: _compHand];
                        [self.imagePC2 setImage: card1.img];
                        compMax = card1.cardIntValue;
                    }
                    else if (count == 2){
                        PGCard *card1 = [self getACard:_compHand];
                        PGCard *card2 = [self getACard:_compHand];
                        [self.imagePC2 setImage: card1.img];
                        [self.imagePC3 setImage: card2.img];
                        compMax = card2.cardIntValue;
                    }
                    else if (count == 3){
                        PGCard *card1 = [self getACard:_compHand];
                        PGCard *card2 = [self getACard:_compHand];
                        PGCard *card3 = [self getACard: _compHand];
                        [self.imageCC2 setImage: card1.img];
                        [self.imageCC3 setImage: card2.img];
                        [self.imageCC4 setImage: card3.img];
                        compMax = card3.cardIntValue;
                    }
                }
                else {
                    
                    PGCard *card1 = [self getACard: _compHand];
                    PGCard *card2 = [self getACard: _compHand];
                    PGCard *card3 = [self getACard: _compHand];
                    PGCard *card4 = [self getACard: _compHand];
                    
                    [self.imageCC2 setImage: card1.img];
                    [self.imageCC3 setImage: card2.img];
                    [self.imageCC4 setImage: card3.img];
                    [self.imageCC5 setImage: card4.img];
                    compMax = card4.cardIntValue;
                }
                
            }
            else if(_compHand.count < 4){
                
                int count = (int)_compHand.count;
                if(count == 1){
                    PGCard *card1 = [self getACard: _compHand];
                    [self.imagePC2 setImage: card1.img];
                    compMax = card1.cardIntValue;
                }
                else if (count == 2){
                    PGCard *card1 = [self getACard:_compHand];
                    PGCard *card2 = [self getACard:_compHand];
                    [self.imagePC2 setImage: card1.img];
                    [self.imagePC3 setImage: card2.img];
                    compMax = card2.cardIntValue;
                }
                else if (count == 3){
                    PGCard *card1 = [self getACard:_compHand];
                    PGCard *card2 = [self getACard:_compHand];
                    PGCard *card3 = [self getACard: _compHand];
                    [self.imageCC2 setImage: card1.img];
                    [self.imageCC3 setImage: card2.img];
                    [self.imageCC4 setImage: card3.img];
                    compMax = card3.cardIntValue;
                }
                
                if(_playerHand.count < 4){
                    
                    int count = (int)_playerHand.count;
                    
                    if(count == 1){
                        PGCard *card1 = [self getACard:_playerHand];
                        [self.imagePC2 setImage: card1.img];
                        playerMax = card1.cardIntValue;
                    }
                    else if (count == 2){
                        PGCard *card1 = [self getACard:_playerHand];
                        PGCard *card2 = [self getACard:_playerHand];
                        [self.imagePC2 setImage: card1.img];
                        [self.imagePC3 setImage: card2.img];
                        playerMax = card2.cardIntValue;
                    }
                    else if (count == 3){
                        PGCard *card1 = [self getACard:_playerHand];
                        PGCard *card2 = [self getACard:_playerHand];
                        PGCard *card3 = [self getACard:_playerHand];
                        [self.imagePC2 setImage: card1.img];
                        [self.imagePC3 setImage: card2.img];
                        [self.imagePC4 setImage: card3.img];
                        playerMax = card3.cardIntValue;
                    }
                }
                else if (count > 3){
                    
                    PGCard *card1 = [self getACard:_playerHand];
                    PGCard *card2 = [self getACard:_playerHand];
                    PGCard *card3 = [self getACard:_playerHand];
                    PGCard *card4 = [self getACard:_playerHand];
                    
                    [self.imagePC2 setImage: card1.img];
                    [self.imagePC3 setImage: card2.img];
                    [self.imagePC4 setImage: card3.img];
                    [self.imagePC5 setImage: card4.img];
                    playerMax = card4.cardIntValue;
                }
                
            }
        }
        else  {
            
            PGCard *card1 = [self getACard: _compHand];
            PGCard *card2 = [self getACard: _compHand];
            PGCard *card3 = [self getACard: _compHand];
            PGCard *card4 = [self getACard: _compHand];
            
            [self.imageCC2 setImage: card1.img];
            [self.imageCC3 setImage: card2.img];
            [self.imageCC4 setImage: card3.img];
            [self.imageCC5 setImage: card4.img];
            compMax = card4.cardIntValue;
            
            
            PGCard *cardC1 = [self getACard:_playerHand];
            PGCard *cardC2 = [self getACard:_playerHand];
            PGCard *cardC3 = [self getACard:_playerHand];
            PGCard *cardC4 = [self getACard:_playerHand];
            
            [self.imagePC2 setImage: cardC1.img];
            [self.imagePC3 setImage: cardC2.img];
            [self.imagePC4 setImage: cardC3.img];
            [self.imagePC5 setImage: cardC4.img];
            playerMax = cardC4.cardIntValue;
            
        }
        
        if(playerMax > compMax){
            self.outputLabel.text = @"Player wins! Press Next Card to continue.";
            [self.nextCardButton setTitle:@"NEXT CARD" forState:UIControlStateNormal];
            [self addPotToHand:_playerHand];
            _potHand = [NSMutableArray new];
            _warTime = NO;
            _leavingWar = YES;
            
        }
        else if( compMax > playerMax ){
            self.outputLabel.text = @"Computer wins. Press Next Card to continue.";
            [self.nextCardButton setTitle:@"NEXT CARD" forState:UIControlStateNormal];
            [self addPotToHand:_compHand];
            _potHand = [NSMutableArray new];
            _warTime = NO;
            _leavingWar = YES;
            
            
        }
        else if( compMax == playerMax ){
            [self.nextCardButton setTitle:@"WAR!!" forState:UIControlStateNormal];
            self.outputLabel.text = @"ITS A WAR. Your cards were the same value. Please press WAR to continue.";
            _warTime = YES;
            _leavingWar = YES;
        }
    }
    
    if (_warTime == NO && _leavingWar == NO){
        
        if(_playerHand.count == 0 ){
            self.myPlayer.losses++;
            self.recordLabel.text = [NSString stringWithFormat: @"W: %d  L: %d", self.myPlayer.wins, self.myPlayer.losses];
            self.outputLabel.text = @"You LOST! Press NEXT CARD to play a new game.";
            _needAReset = YES;
        }
        if(_compHand.count == 0){
            self.myPlayer.wins++;
            self.recordLabel.text = [NSString stringWithFormat: @"W: %d  L: %d", self.myPlayer.wins, self.myPlayer.losses];
            self.outputLabel.text = @"You Won! Press NEXT CARD to play a new game.";
            _needAReset = YES;
        }
        
        [self resetCardsAfterWar];
        [self.nextCardButton setTitle:@"NEXT CARD" forState:UIControlStateNormal ];
        _playerC = [self getACard: self.playerHand];
        _compC = [self getACard: self.compHand];
        [self.imagePC1 setImage:_playerC.img];
        [self.imageCC1 setImage:_compC.img];
        
        if(_playerC.cardIntValue > _compC.cardIntValue){
            self.outputLabel.text = @"Player wins! Press Next Card to continue.";
            [self addPotToHand:_playerHand];
            _potHand = [NSMutableArray new];
            _warTime = NO;
            _leavingWar = NO;
        }
        else if (_playerC.cardIntValue < _compC.cardIntValue ){
            
            self.outputLabel.text = @"Computer wins. Press Next Card to continue.";
            [self addPotToHand:_compHand];
            _potHand = [NSMutableArray new];
            _warTime = NO;
            _leavingWar = NO;
            
        }
        else if (_playerC.cardIntValue == _compC.cardIntValue ){

            _warTime = YES;
            [self.nextCardButton setTitle:@"WAR!!" forState:UIControlStateNormal];
            self.outputLabel.text = @"ITS A WAR. Your cards were the same value. Please press WAR to continue.";
            _leavingWar = NO;
        }
    }
}

/******************************
 these control card ImageViews
 ******************************/

-(void)resetCardsAfterWar{
    [_imagePC2 setAlpha:0.00];
    [_imagePC3 setAlpha:0.00];
    [_imagePC4 setAlpha:0.00];
    [_imagePC5 setAlpha:0.00];
    [_imageCC2 setAlpha:0.00];
    [_imageCC3 setAlpha:0.00];
    [_imageCC4 setAlpha:0.00];
    [_imageCC5 setAlpha:0.00];
}

-(void)makeCardsVisable{
    [_imagePC2 setAlpha:1];
    [_imagePC3 setAlpha:1];
    [_imagePC4 setAlpha:1];
    [_imagePC5 setAlpha:1];
    [_imageCC2 setAlpha:1];
    [_imageCC3 setAlpha:1];
    [_imageCC4 setAlpha:1];
    [_imageCC5 setAlpha:1];
}

/**************************************************************************************
    This method cuts the deck, but it is not shuffled.
 **************************************************************************************/

-(void)splitTheDeck{
    
    for (int i = 0; i < 52; i++ ){
        if (i%2==0){
            [self.playerHand addObject: [self.myDeck.cardDeckArr objectAtIndex:i]];
        }
        else {
            [self.compHand addObject: [self.myDeck.cardDeckArr objectAtIndex:i]];
        }
    }
    
}

@end

//
//  PGDeck.m
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "PGDeck.h"
#import "PGCard.h"

@implementation PGDeck




-(void)addACard: (PGCard *) card{
    
    [self.cardDeckArr addObject:card];
    
}


-(PGDeck*)init{
    self = [super init];
    if(self){
        self = [self getADeck];
        self.index = 0;
    }
    return self;
}

-(PGDeck*)getADeck {
    
    self.tempArr = [NSMutableArray array];
    self.cardDeckArr = [NSMutableArray array];
    
    for( int i = 2; i<15; i++){
        for(SUIT mySuit = CLUBS; mySuit < 5; mySuit++){
            
            PGCard *tempCard = [[PGCard alloc]initWithIntValue: i andSUIT: mySuit];
            [self.tempArr addObject:tempCard];
            
        }
    }
    
    
    PGCard *addCard = [self.tempArr objectAtIndex:0];
    addCard.img = [UIImage imageNamed:@"2_of_clubs.png"];
    addCard.cardStringValue = @"2_of_clubs.png";
    [self.cardDeckArr addObject:addCard];

    addCard = [self.tempArr objectAtIndex:1];
    addCard.img = [UIImage imageNamed:@"2_of_diamonds.png"];
    addCard.cardStringValue = @"2_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:2];
    addCard.img = [UIImage imageNamed:@"2_of_hearts.png"];
    addCard.cardStringValue = @"2_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:3];
    addCard.img = [UIImage imageNamed:@"2_of_spades.png"];
    addCard.cardStringValue = @"2_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:4];
    addCard.img = [UIImage imageNamed:@"3_of_clubs.png"];
    addCard.cardStringValue = @"3_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:5];
    addCard.img = [UIImage imageNamed:@"3_of_diamonds.png"];
    addCard.cardStringValue = @"3_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:6];
    addCard.img = [UIImage imageNamed:@"3_of_hearts.png"];
    addCard.cardStringValue = @"3_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:7];
    addCard.img = [UIImage imageNamed:@"3_of_spades.png"];
    addCard.cardStringValue = @"3_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:8];
    addCard.img = [UIImage imageNamed:@"4_of_clubs.png"];
    addCard.cardStringValue = @"4_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:9];
    addCard.img = [UIImage imageNamed:@"4_of_diamonds.png"];
    addCard.cardStringValue = @"4_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:10];
    addCard.img = [UIImage imageNamed:@"4_of_hearts.png"];
    addCard.cardStringValue = @"4_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:11];
    addCard.img = [UIImage imageNamed:@"4_of_spades.png"];
    addCard.cardStringValue = @"4_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:12];
    addCard.img = [UIImage imageNamed:@"5_of_clubs.png"];
    addCard.cardStringValue = @"5_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:13];
    addCard.img = [UIImage imageNamed:@"5_of_diamonds.png"];
    addCard.cardStringValue = @"5_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:14];
    addCard.img = [UIImage imageNamed:@"5_of_hearts.png"];
    addCard.cardStringValue = @"5_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:15];
    addCard.img = [UIImage imageNamed:@"5_of_spades.png"];
    addCard.cardStringValue = @"5_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:16];
    addCard.img = [UIImage imageNamed:@"6_of_clubs.png"];
    addCard.cardStringValue = @"6_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:17];
    addCard.img = [UIImage imageNamed:@"6_of_diamonds.png"];
    addCard.cardStringValue = @"6_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:18];
    addCard.img = [UIImage imageNamed:@"6_of_hearts.png"];
    addCard.cardStringValue = @"6_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [self.tempArr objectAtIndex:19];
    addCard.img = [UIImage imageNamed:@"6_of_spades.png"];
    addCard.cardStringValue = @"6_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:20];
    addCard.img = [UIImage imageNamed:@"7_of_clubs.png"];
    addCard.cardStringValue = @"7_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:21];
    addCard.img = [UIImage imageNamed:@"7_of_diamonds.png"];
    addCard.cardStringValue = @"7_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:22];
    addCard.img = [UIImage imageNamed:@"7_of_hearts.png"];
    addCard.cardStringValue = @"7_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:23];
    addCard.img = [UIImage imageNamed:@"7_of_spades.png"];
    addCard.cardStringValue = @"7_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:24];
    addCard.img = [UIImage imageNamed:@"8_of_clubs.png"];
    addCard.cardStringValue = @"8_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:25];
    addCard.img = [UIImage imageNamed:@"8_of_diamonds.png"];
    addCard.cardStringValue = @"8_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:26];
    addCard.img = [UIImage imageNamed:@"8_of_hearts.png"];
    addCard.cardStringValue = @"8_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:27];
    addCard.img = [UIImage imageNamed:@"8_of_spades.png"];
    addCard.cardStringValue = @"8_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:28];
    addCard.img = [UIImage imageNamed:@"9_of_clubs.png"];
    addCard.cardStringValue = @"9_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:29];
    addCard.img = [UIImage imageNamed:@"9_of_diamonds.png"];
    addCard.cardStringValue = @"9_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:30];
    addCard.img = [UIImage imageNamed:@"9_of_hearts.png"];
    addCard.cardStringValue = @"9_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:31];
    addCard.img = [UIImage imageNamed:@"9_of_spades.png"];
    addCard.cardStringValue = @"9_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:32];
    addCard.img = [UIImage imageNamed:@"10_of_clubs.png"];
    addCard.cardStringValue = @"10_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:33];
    addCard.img = [UIImage imageNamed:@"10_of_diamonds.png"];
    addCard.cardStringValue = @"10_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:34];
    addCard.img = [UIImage imageNamed:@"10_of_hearts.png"];
    addCard.cardStringValue = @"10_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:35];
    addCard.img = [UIImage imageNamed:@"10_of_spades.png"];
    addCard.cardStringValue = @"10_of_spades.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:36];
    addCard.img = [UIImage imageNamed:@"jack_of_clubs2.png"];
    addCard.cardStringValue = @"jack_of_clubs2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:37];
    addCard.img = [UIImage imageNamed:@"jack_of_diamonds2.png"];
    addCard.cardStringValue = @"jack_of_diamonds2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:38];
    addCard.img = [UIImage imageNamed:@"jack_of_hearts2.png"];
    addCard.cardStringValue = @"jack_of_hearts2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:39];
    addCard.img = [UIImage imageNamed:@"jack_of_spades2.png"];
    addCard.cardStringValue = @"jack_of_spades2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:40];
    addCard.img = [UIImage imageNamed:@"queen_of_clubs2.png"];
    addCard.cardStringValue = @"queen_of_clubs2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:41];
    addCard.img = [UIImage imageNamed:@"queen_of_diamonds2.png"];
    addCard.cardStringValue = @"queen_of_diamonds2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:42];
    addCard.img = [UIImage imageNamed:@"queen_of_hearts2.png"];
    addCard.cardStringValue = @"queen_of_hearts2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:43];
    addCard.img = [UIImage imageNamed:@"queen_of_spades2.png"];
    addCard.cardStringValue = @"queen_of_spades2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:44];
    addCard.img = [UIImage imageNamed:@"king_of_clubs2.png"];
    addCard.cardStringValue = @"king_of_clubs2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:45];
    addCard.img = [UIImage imageNamed:@"king_of_diamonds2.png"];
    addCard.cardStringValue = @"king_of_diamonds2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:46];
    addCard.img = [UIImage imageNamed:@"king_of_hearts2.png"];
    addCard.cardStringValue = @"king_of_hearts2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:47];
    addCard.img = [UIImage imageNamed:@"king_of_spades2.png"];
    addCard.cardStringValue = @"king_of_spades2.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:48];
    addCard.img = [UIImage imageNamed:@"ace_of_clubs.png"];
    addCard.cardStringValue = @"ace_of_clubs.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:49];
    addCard.img = [UIImage imageNamed:@"ace_of_diamonds.png"];
    addCard.cardStringValue = @"ace_of_diamonds.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:50];
    addCard.img = [UIImage imageNamed:@"ace_of_hearts.png"];
    addCard.cardStringValue = @"ace_of_hearts.png";
    [self addACard: addCard];
    
    
    addCard = [_tempArr objectAtIndex:51];
    addCard.img = [UIImage imageNamed:@"ace_of_spades.png"];
    addCard.cardStringValue = @"ace_of_spades.png";
    [self addACard: addCard];
    
    return self;

}

-(void) shuffleDeck {
    
    for(int i = 0; i < [self.cardDeckArr count]-1; i++) {
        int randInt  = (arc4random() % ([self.cardDeckArr count] - i)) + i;
        [self.cardDeckArr exchangeObjectAtIndex:i withObjectAtIndex:randInt];
    }
    
}

-(PGCard *)getNextCard{
    
    if(self.index < self.cardDeckArr.count){
        
        PGCard *retCard = [self.cardDeckArr objectAtIndex:self.index];
        
        if(retCard.alreadyDealt == YES){
            self.index++;
            [self getNextCard];
        }
        
        self.index++;
        return retCard;
    }
    else
        
        self.index = 0;
        
        [self shuffleDeck];
        PGCard *retCard = [self.cardDeckArr objectAtIndex:self.index];
        self.index++;
        retCard.alreadyDealt = YES;
        return retCard;
 
}

@end

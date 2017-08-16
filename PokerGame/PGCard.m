//
//  PGCard.m
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "PGCard.h"

@implementation PGCard

-(PGCard*)initWithIntValue: (int) value andSUIT: (SUIT) suit{
    
    self = [super init];
    if(self){
        self.cardIntValue = value;
        self.cardSuit = suit;
        self.wasSelected = NO;
        self.alreadyDealt = NO;
    }
    return self;
}

-(NSString *)getCardStringValue {
    return self.cardStringValue;
}

@end

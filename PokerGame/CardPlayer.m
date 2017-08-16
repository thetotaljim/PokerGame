//
//  CardPlayer.m
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "CardPlayer.h"

@implementation CardPlayer

static CardPlayer *player = nil;

+(CardPlayer*) sharedPlayer {
    if(player == nil){
        player = [[super alloc]init];
    }
    return player;
}

-(id)init {
    self = [super init];
    if(self){
        self.icon = nil;
        self.firstName = nil;
        self.lastName = nil;
        self.email = nil;
        self.age = 0;
        self.wins = 0;
        self.losses = 0;
        self.iconPath = nil;
        
        self.compDifficulty = 0;
        self.easy = 8;
        self.med = 10;
        self.hard = 12;
    }
    return self;
}

@end

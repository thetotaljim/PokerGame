//
//  PGDeck.h
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PGCard.h"

@interface PGDeck : NSObject

@property NSMutableDictionary *cardDeckDic;
@property int index;
@property NSMutableArray *tempArr;

@property NSMutableArray *cardDeckArr;

-(void)addACard: (PGCard *) card;

-(PGDeck*)getADeck ;

-(void)shuffleDeck;
-(PGCard *)getNextCard;

@end

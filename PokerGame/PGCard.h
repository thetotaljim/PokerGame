//
//  PGCard.h
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PGCard : NSObject

@property int cardIntValue;
@property NSString* cardStringValue;
@property Boolean wasSelected;

@property Boolean alreadyDealt;

-(NSString *)getCardStringValue;

/*
 
    two = 2;
    three = 3;
    four = 4;
    five = 5;
    six = 6;
    seven = 7;
    eight = 8;
    nine = 9;
    ten = 10;
    jack = 11;
    queen = 12;
    king = 13;
    ace = 14;
 
*/

@property UIImage *img;

typedef enum{
    
    CLUBS = 1,
    DIAMONDS = 2,
    HEARTS = 3,
    SPADES = 4
    
}SUIT;

@property SUIT cardSuit;

-(PGCard*)initWithIntValue: (int) value andSUIT: (SUIT) suit;


@end

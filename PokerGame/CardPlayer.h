//
//  CardPlayer.h
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CardPlayer : NSObject

@property int compDifficulty;
@property int easy;
@property int med;
@property int hard;

@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;
@property int age;

@property int wins;
@property int losses;

@property UIImage *icon;
@property NSString *iconPath;

+(CardPlayer*) sharedPlayer;

@end

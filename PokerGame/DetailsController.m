//
//  DetailsController.m
//  PokerGame
//
//  Created by James Steimel on 7/26/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//
//

#import "DetailsController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PGCard.h"
#import "PGDeck.h"
#import "CardPlayer.h"
#import "GameController.h"


@interface DetailsController (){
    
    NSArray *_pickerData;
}

@end

@implementation DetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myPlayer = [CardPlayer sharedPlayer];
    
    
    /*  *********************************************************************
            Working with Picker View
     ************************************************************************/
    
    _pickerData = @[@"Easy", @"Medium", @"Hard"];
    
    //Connect Data to picker
    self.difficultyPicker.dataSource = self;
    self.difficultyPicker.delegate = self;
    
    
    UIImage *backgroundImage = [UIImage imageNamed:@"perlinfelt1.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    /*
        and now use the Singleton myPlayer to set the icon and player info. 
    */
    
    [self.playerIcon setImage: [UIImage imageNamed: self.myPlayer.iconPath]];
    
    /*  The below is the code i will use to make my card images 
        accept presses.  then i will handle those presses, and change the image.
        The code for using animation and such is in the intermidate notes.
        use the dice game with imageviews as a template.
     */
    
    
    [self.playerIcon setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.playerIcon addGestureRecognizer:singleTap];
    
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.myPlayer.firstName, self.myPlayer.lastName];
    self.emailLabel.text = self.myPlayer.email;
    self.ageLabel.text = [NSString stringWithFormat: @"%d", self.myPlayer.age];
    self.recordLabel.text = [NSString stringWithFormat:@"W: %d  L: %d", self.myPlayer.wins, self.myPlayer.losses ];
    
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


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *) pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickerData.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *pickerResult = _pickerData[row];
    if ( [pickerResult isEqualToString: @"Easy" ] ){
        self.myPlayer.compDifficulty = 8;
    }
    if ( [pickerResult isEqualToString: @"Medium" ] ){
        self.myPlayer.compDifficulty = 10;
    }
    if ( [pickerResult isEqualToString: @"Hard" ] ){
        self.myPlayer.compDifficulty = 12;
    }
}



- (IBAction)pressContinueButton:(id)sender {
    
       [self performSegueWithIdentifier:@"MoveToGameView" sender:sender];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MoveToGameView"]){
        GameController *destination = segue.destinationViewController;
        destination.myPlayer = self.myPlayer;
    }
    if([segue.identifier isEqualToString:@"MoveToWar"]){
        GameController *destination = segue.destinationViewController;
        destination.myPlayer = self.myPlayer;
    }
}

-(void)singleTapping:(UIGestureRecognizer *)recognizer{
    

    NSLog(@"Here is where the image tapping code would be placed.");
}

- (IBAction)warButtonPressed:(id)sender {
    
    
}

@end

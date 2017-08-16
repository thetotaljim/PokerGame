//
//  IconController.m
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "IconController.h"
#import "PGCard.h"
#import "PGDeck.h"
#import "CardPlayer.h"
#import "DetailsController.h"

@interface IconController ()

@end

@implementation IconController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.continueButton.enabled = NO;
    
    self.myPlayer = [CardPlayer sharedPlayer];
    NSLog(@"%@", self.myPlayer.firstName);
    
    //  SET BACKGROUND IMAGE
    UIImage *backgroundImage = [UIImage imageNamed:@"perlinfelt1.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
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

- (IBAction)selectIcon6:(id)sender {
    
    self.myPlayer.icon = [UIImage imageNamed:@"woman3_128x128.png"];
    self.continueButton.enabled = YES;
    self.myPlayer.iconPath = @"woman3_128x128.png";
}

- (IBAction)selectIcon1:(id)sender {
    
    self.myPlayer.icon = [UIImage imageNamed:@"man1_128x128.png"];
    self.continueButton.enabled = YES;
    self.myPlayer.iconPath = @"man1_128x128.png";
}

- (IBAction)selectIcon2:(id)sender {
   
    self.myPlayer.icon = [UIImage imageNamed:@"man2_128x128.png"];
    self.continueButton.enabled = YES;
    self.myPlayer.iconPath = @"man2_128x128.png";
}

- (IBAction)selectIcon3:(id)sender {
    
    self.myPlayer.icon = [UIImage imageNamed:@"man3_128x128.png"];
    self.continueButton.enabled = YES;
    self.myPlayer.iconPath = @"man3_128x128.png";
}

- (IBAction)selectIcon4:(id)sender {
    
    self.myPlayer.icon = [UIImage imageNamed:@"man4_128x128.png"];
    self.continueButton.enabled = YES;
    self.myPlayer.iconPath = @"man4_128x128.png";
}

- (IBAction)selectIcon5:(id)sender {
    
    self.myPlayer.icon = [UIImage imageNamed:@"woman5_128x128.png"];
    self.continueButton.enabled = YES;
    self.myPlayer.iconPath = @"woman5_128x128.png";
    
}
- (IBAction)pressToView3:(id)sender {
    
    [self performSegueWithIdentifier:@"MoveToGameDetails" sender:sender];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MoveToGameDetails"]){
        DetailsController *destination = segue.destinationViewController;
        // destination.cntr = self.cntr;
        destination.myPlayer = self.myPlayer;
    }
}
@end

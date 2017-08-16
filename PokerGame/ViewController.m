//
//  ViewController.m
//  PokerGame
//
//  Created by James Steimel on 7/25/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

#import "ViewController.h"
#import "IconController.h"
#import "CardPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Instanciate some different variables.
    self.continueView2.enabled = NO;
    self.myPlayer = [CardPlayer sharedPlayer];
    
    
    // Here I set my background image.
    UIImage *backgroundImage = [UIImage imageNamed:@"perlinfelt1.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/******************************************************************
        pressToView2  -> this checks user input before segue to
        next view
 *****************************************************************/

- (IBAction)pressToView2:(id)sender {
    
    // Age is forced to be a number. Uses NSCharacterSet and isSuperSetOfSet to accomplish this.
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString: self.ageTextField.text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    
    //  Here i just check to make sure that the user has entered all the fields.
    if ( self.emailTextField.text.length == 0 || self.firstTextField.text.length == 0 || self.lastTextField.text.length == 0 || self.ageTextField == 0 ) {
        // If not, they get an error message
        self.topLabel.text = @"You did not enter all fields. Please try again.";
    }
    else if (!valid ) {
       self.topLabel.text = @"Your age must be a number. Please try again.";
    }
    else{
        self.myPlayer.firstName = self.firstTextField.text;
        self.myPlayer.lastName = self.lastTextField.text;
        self.myPlayer.age = [self.ageTextField.text intValue];
        self.myPlayer.email = self.emailTextField.text;
       [self performSegueWithIdentifier:@"MoveToIconView" sender:sender];
    }
  
}

/*************************************************************************
        textFieldShouldReturn -> allow text fields to return data
 ************************************************************************/

-(BOOL)textFieldShouldReturn: (UITextField *)myTextField {
    
    if (myTextField == self.firstTextField){
        [myTextField resignFirstResponder];
    }
    if (myTextField == self.lastTextField){
        [myTextField resignFirstResponder];
    }
    if (myTextField == self.ageTextField){
        [myTextField resignFirstResponder];
    }
    if (myTextField == self.emailTextField){
        [myTextField resignFirstResponder];
    }
    return YES;
}

/***************************************************************************
        Here we set a label when text begins to be entered. 
 **************************************************************************/

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.topLabel.text = @"Thanks for playing at Jim's Card Table.  Please enter some info before we get started!";
    self.continueView2.enabled = YES;
    
}

/***************************************************************************
    Here we set data so it can be used elsewhere in out program
 ***************************************************************************/


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MoveToIconView"]){
        IconController *destination = segue.destinationViewController;
       // destination.cntr = self.cntr;
        destination.myPlayer.firstName = self.myPlayer.firstName;
        destination.myPlayer.lastName = self.myPlayer.lastName;
        destination.myPlayer.age = self.myPlayer.age;
        destination.myPlayer.email = self.myPlayer.email;
    }
}


@end

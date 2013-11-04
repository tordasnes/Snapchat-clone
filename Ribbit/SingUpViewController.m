//
//  SingUpViewController.m
//  Ribbit
//
//  Created by Tord Åsnes on 04/11/13.
//  Copyright (c) 2013 Tord Åsnes. All rights reserved.
//

#import "SingUpViewController.h"
#import <Parse/Parse.h>

@interface SingUpViewController ()

@end

@implementation SingUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)signUp:(id)sender {
    NSString *username = [self.usernameField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.passwordField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *email = [self.emailField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you enter a username, password and an email!"
                                                           delegate:Nil cancelButtonTitle:@"Okey"
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
        PFUser *newUser = [PFUser user];
        [newUser setUsername:username];
        [newUser setPassword:password];
        [newUser setEmail:email];
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                   delegate:Nil cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }

}

@end

//
//  MainViewController.m
//  UpUnet-S
//
//  Created by Christopher Loessl on 5/27/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

// TODO: Save username + password in keychain
// TODO: Save auto connect setting in NSUserDefaults
// TODO: Find out if we have connection to the internet via wifi
#pragma mark -

#import "MainViewController.h"
#import "AFHTTPClient.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@end

@implementation MainViewController

static NSString *const BaseURLString = @"https://netlogon.student.uu.se/";

- (IBAction)connectButton:(UIButton *)sender {
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:BaseURLString]];
    NSDictionary *parameters;
    
    if (sender == self.connectButton) {
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Login", @"action",
                                    @"UpUnet-S", @"usergroup",
                                    @"USERNAME", @"username",
                                    @"PASSWORD", @"password",
                                    nil];
    } else if (sender == self.disconnectButton) {
        parameters = [NSDictionary dictionaryWithObject:@"Logout" forKey:@"action"];
    } else {
        NSLog(@"Error!");
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                     message:@"Can't dicede which button"
                                                    delegate:nil
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles:nil];
        [av show];
        return;
    }
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client postPath:@"/"
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                 NSString* newStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                 [self.webView loadHTMLString:newStr baseURL:[NSURL URLWithString:@""]];
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:[NSString stringWithFormat:@"%@", error]
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                 [av show];
             }
     ];
}

@end

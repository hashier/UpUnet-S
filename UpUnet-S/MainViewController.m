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
// TODO: Maybe support SLU as well?
#pragma mark -

#import "MainViewController.h"
#import "UpUnet-SConnector.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property (strong, nonatomic) UpUnet_SConnector *connectToUpUnetS;
@end

@implementation MainViewController

- (UpUnet_SConnector *)connectToUpUnetS {
    if (!_connectToUpUnetS) _connectToUpUnetS = [[UpUnet_SConnector alloc] init];
    return _connectToUpUnetS;
}

- (IBAction)connectButton:(UIButton *)sender {
    if (sender == self.connectButton) {
        [self.connectToUpUnetS connect];
    } else if (sender == self.disconnectButton) {
        [self.connectToUpUnetS disconnect];
    } else {
        NSLog(@"Error!");
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                     message:@"Can't decide which button"
                                                    delegate:nil
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles:nil];
        [av show];
        return;
    }
}

@end

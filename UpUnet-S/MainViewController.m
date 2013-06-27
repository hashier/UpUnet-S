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
#import "Reachability.h"

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

// TODO: try out: reachability-ios
// because reachability is not working
// maybe check out:
// https://github.com/belkevich/reachability-ios
- (void)whatIsMyStatus {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    NSLog(@"%@", [reach currentReachabilityFlags]);
    NSLog(@"%@", [reach currentReachabilityString]);
    
    if ([reach isInterventionRequired]) {
        NSLog(@"User intervention needed");
    } else {
        NSLog(@"Connected to the internet");
    }
    
    reach.reachableBlock = ^(Reachability *reach) {
        NSLog(@"REACHABLE!");
    };
    
    reach.unreachableBlock = ^(Reachability *reach) {
        NSLog(@"NOT REACHABLE!");
    };
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self whatIsMyStatus];
//}

@end

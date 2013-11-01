//
//  MainViewController.m
//  UpUnet-S
//
//  Created by Christopher Loessl on 5/27/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#pragma mark -

#import "MainViewController.h"
#import "UpUnet-SConnector.h"
#import "SSKeychain.h"
#import "Constants.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property (strong, nonatomic) UpUnet_SConnector *connectToUpUnetS;
@end

@implementation MainViewController

- (UpUnet_SConnector *)connectToUpUnetS {
    if (!_connectToUpUnetS) _connectToUpUnetS = [[UpUnet_SConnector alloc] init];
    return _connectToUpUnetS;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)becomeActive:(NSNotification *)notification {
    // autoconnect yes/no?
    if ([[NSUserDefaults standardUserDefaults] boolForKey:UPUNETS_AUTOCONNECT]) {
        // press button connect
        [self.connectButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)showMsg:(NSString *)msg withTitle:(NSString *)title {
    NSLog(@"%@:%@", title, msg);
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title
                                                 message:msg
                                                delegate:nil
                                       cancelButtonTitle:@"Ok"
                                       otherButtonTitles:nil];
    [av show];
}

- (IBAction)connectButton:(UIButton *)sender
{
    if (sender == self.connectButton) {
        [self.connectToUpUnetS connect];
    } else if (sender == self.disconnectButton) {
        [self.connectToUpUnetS disconnect];
    } else {
        [self showMsg:@"Can't decide which button" withTitle:@"Error!"];
        return;
    }
}

@end

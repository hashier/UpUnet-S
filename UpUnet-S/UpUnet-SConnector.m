//
//  UpUnet-SConnector.m
//  UpUnet-S
//
//  Created by Christopher Loessl on 5/30/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import "UpUnet-SConnector.h"
#import "SSKeychain.h"
#import "Constants.h"

@implementation UpUnet_SConnector

static NSString *const BaseURLString = @"https://netlogon.student.uu.se/";

- (id)init {
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:BaseURLString]];
    self = [super initWithBaseURL:baseURL];
    if (self) {
        //
    }
    // FIXME: Testing
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"I'm a block (: and status is: %d", status);
    }];
    return self;
}

- (void)doNetwork:(NSDictionary *)parameters {
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:BaseURLString]];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client postPath:@"/"
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 //
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

- (void)showMsg:(NSString *)msg withTitle:(NSString *)title {
    NSLog(@"%@:%@", title, msg);
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title
                                                 message:msg
                                                delegate:nil
                                       cancelButtonTitle:@"Ok"
                                       otherButtonTitles:nil];
    [av show];
}

- (void)connect
{
    BOOL userAndPasswordNonEmpty = (([SSKeychain passwordForService:SERVICE account:USER] > 0) && ([SSKeychain passwordForService:SERVICE account:PASSWORD] > 0));
    if (!userAndPasswordNonEmpty) {
        [self showMsg:@"You need to fill out username and password in the settings tab" withTitle:@"Warning!"];
    }
    
    NSDictionary *parameters;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"Login", @"action",
                  @"UpUnet-S", @"usergroup",
                  [SSKeychain passwordForService:SERVICE account:USER], @"username",
                  [SSKeychain passwordForService:SERVICE account:PASSWORD], @"password",
                  nil];
    [self doNetwork:parameters];
}

- (void)disconnect {
    NSDictionary *parameters;
    parameters = [NSDictionary dictionaryWithObject:@"Logout" forKey:@"action"];
    [self doNetwork:parameters];
}

@end

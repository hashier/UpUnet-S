//
//  UpUnet-SConnector.m
//  UpUnet-S
//
//  Created by Christopher Loessl on 5/30/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import "UpUnet-SConnector.h"

@implementation UpUnet_SConnector

static NSString *const BaseURLString = @"https://netlogon.student.uu.se/";

- (id)init {
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:BaseURLString]];
    self = [super initWithBaseURL:baseURL];
    if (self) {
        //
    }
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

- (void)connect {
    NSDictionary *parameters;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"Login", @"action",
                  @"UpUnet-S", @"usergroup",
                  @"USERNAME", @"username",
                  @"PASSWORD", @"password",
                  nil];
    [self doNetwork:parameters];
}

- (void)disconnect {
    NSDictionary *parameters;
    parameters = [NSDictionary dictionaryWithObject:@"Logout" forKey:@"action"];
    [self doNetwork:parameters];
}

@end

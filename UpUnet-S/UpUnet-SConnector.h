//
//  UpUnet-SConnector.h
//  UpUnet-S
//
//  Created by Christopher Loessl on 5/30/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import "AFHTTPClient.h"

@interface UpUnet_SConnector : AFHTTPClient
- (void)connect;
- (void)disconnect;
@end

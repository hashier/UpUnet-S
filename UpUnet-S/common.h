//
//  common.h
//  Common helper stuff
//
//  Created by Christopher Loessl
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#ifndef hashier_common_h
#define hashier_common_h

#ifdef DEBUG
#define DLog(...) NSLog(@"(%@:%d %s) %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...)
#endif


#endif

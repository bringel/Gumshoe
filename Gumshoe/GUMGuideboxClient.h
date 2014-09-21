//
//  GUMGuideboxClient.h
//  Gumshoe
//
//  Created by Bradley Ringel on 9/21/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface GUMGuideboxClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

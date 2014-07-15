//
//  VSRRottentTomatesClient.h
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface VSRRottentTomatesClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)searchForMovieWithTitle:(NSString *)title success:(void (^)(NSArray *))successBlock failure:(void (^)(NSError *))failBlock;

@end

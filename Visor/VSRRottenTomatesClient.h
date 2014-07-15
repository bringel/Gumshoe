//
//  VSRRottentTomatesClient.h
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface VSRRottenTomatesClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)searchForMovieWithTitle:(NSString *)title success:(void (^)(NSArray *movieData))successBlock failure:(void (^)(NSError *error))failBlock;

@end

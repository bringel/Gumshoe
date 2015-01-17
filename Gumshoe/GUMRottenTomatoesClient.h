//
//  VSRRottentTomatesClient.h
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "AFHTTPSessionManager.h"
@class PMKPromise;

@interface GUMRottenTomatoesClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (PMKPromise *)searchForMovieWithTitle:(NSString *)title;

@end

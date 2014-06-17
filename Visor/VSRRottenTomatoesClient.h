//
//  VSRRottenTomatoesManager.h
//  Visor
//
//  Created by Bradley Ringel on 6/15/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface VSRRottenTomatoesClient : AFHTTPSessionManager

+ (instancetype)sharedManager;
- (NSString *)apiKey;

- (void)searchMoviesWithTitle:(NSString *)title completion:(void (^)(NSDictionary *))completion;


@end

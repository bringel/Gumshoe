//
//  GUMMovieDatabaseClient.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/24/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//
//  This is an AFNetworking client for themoviedb.org

#import "AFHTTPSessionManager.h"

@interface GUMMovieDatabaseClient : AFHTTPSessionManager

@property (nonatomic, strong) NSURL *posterBaseURL;
+ (instancetype)sharedClient;

- (void)searchForMovieWithTitle:(NSString *)title success:(void (^)(NSArray *))successBlock failure:(void (^)(NSError *))failureBlock;
- (NSURL *)posterBaseURL;

@end

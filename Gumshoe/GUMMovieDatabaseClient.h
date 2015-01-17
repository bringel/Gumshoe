//
//  GUMMovieDatabaseClient.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/24/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//
//  This is an AFNetworking client for themoviedb.org

#import "AFHTTPSessionManager.h"
#import "GUMItemSearchClient.h"
#import "Promise.h"

@interface GUMMovieDatabaseClient : AFHTTPSessionManager <GUMItemSearchClient>

@property (nonatomic, strong) NSURL *posterBaseURL;
+ (instancetype)sharedClient;

- (PMKPromise *)searchForMovieWithTitle:(NSString *)title;
- (PMKPromise *)getMovieInformation:(NSNumber *)movieId;

@end

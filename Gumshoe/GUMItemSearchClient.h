//
//  GUMItemSearchClient.h
//  Gumshoe
//
//  Created by Bradley Ringel on 1/1/15.
//  Copyright (c) 2015 Bradley Ringel. All rights reserved.
//
@class PMKPromise;

@protocol GUMItemSearchClient <NSObject>

+ (instancetype)sharedClient;

- (PMKPromise *)searchForItemWithTitle:(NSString *)title;

@end
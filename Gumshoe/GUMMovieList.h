//
//  GUMMovieList.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@class GUMMovie;

@interface GUMMovieList : MTLModel

- (void)addMovie:(GUMMovie *)movie;

- (NSUInteger)count;
- (GUMMovie *)movieAtIndex:(NSUInteger)index;
@end

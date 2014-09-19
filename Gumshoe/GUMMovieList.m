//
//  GUMMovieList.m
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMMovieList.h"
#import "GUMMovie.h"

@interface GUMMovieList()

@property (strong, nonatomic) NSMutableArray *movies;

@end

@implementation GUMMovieList

- (NSMutableArray *)movies{
    if(_movies == nil){
        _movies = [[NSMutableArray alloc] init];
    }
    return _movies;
}

- (void)addMovie:(GUMMovie *)movie{
    [self.movies addObject:movie];
}

- (NSUInteger)count{
    return [self.movies count];
}

- (GUMMovie *)movieAtIndex:(NSUInteger)index{
    return [self.movies objectAtIndex:index];
}

@end

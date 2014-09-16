//
//  GUMMovie.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

typedef enum : NSUInteger {
    GUMNotReleased,
    GUMReleased,
} GUMMovieStatus;
@interface GUMMovie : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *theatricalReleaseDate;
@property (strong, nonatomic) NSNumber *moviedbID;
@property (strong, nonatomic) NSString *imdbID;
@property (strong, nonatomic) NSString *synopsis;
@property (strong, nonatomic) NSString *posterPath;
@property (nonatomic) GUMMovieStatus status;

@end

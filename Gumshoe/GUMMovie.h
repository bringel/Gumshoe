//
//  GUMMovie.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface GUMMovie : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *theatricalReleaseDate;
@property (strong, nonatomic) NSString *rottentomatoesID;

@end

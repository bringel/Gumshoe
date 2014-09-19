//
//  GUMUser.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GUMMovieList.h"
#import "MTLModel.h"

@interface GUMUser : MTLModel

@property (strong, nonatomic) GUMMovieList *movieList;

+ (instancetype)currentUser;

- (void)saveUser;
@end

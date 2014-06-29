//
//  VSRMovieTitle.h
//  Visor
//
//  Created by Bradley Ringel on 6/28/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface VSRMovie : NSManagedObject

@property (nonatomic, retain) NSData * coverImage;
@property (nonatomic, retain) NSString * imdbID;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * rottenTomatoesID;

@end

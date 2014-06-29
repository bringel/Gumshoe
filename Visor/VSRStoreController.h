//
//  VSRStoreController.h
//  Visor
//
//  Created by Bradley Ringel on 6/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VSRTitleType) {
    VSRTitleTypeMovie,
};

@interface VSRStoreController : NSObject

+ (instancetype)sharedController;

- (BOOL)addMovieWithMovieInfo:(NSDictionary *)movieInfo coverImage:(NSData *)imageData;
@end

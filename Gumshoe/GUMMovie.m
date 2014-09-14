//
//  GUMMovie.m
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMMovie.h"
#import "MTLValueTransformer.h"

@implementation GUMMovie

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"moviedbID" : @"id",
             @"theatricalReleaseDate" : @"release_date",
             @"title" : @"title",
             @"synopsis" : @"overview",
             @"imdbID" : @"imdb_id",
             @"status" : @"status"
             };
}

+ (NSValueTransformer *)theatricalReleaseDateValueTransformer{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-mm-dd";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    
    return [MTLValueTransformer transformerWithBlock:^NSDate *(NSString *dateString) {
        return [formatter dateFromString:dateString];
    }];
}

+ (NSValueTransformer *)statusValueTransformer{
    return [[NSValueTransformer alloc] init];
}

@end

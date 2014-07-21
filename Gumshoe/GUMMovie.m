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
             @"rottentomatoesID" : @"id",
             @"theatricalReleaseDate" : @"release_dates.theater",
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

@end

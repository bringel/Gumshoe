//
//  GUMMovie.m
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMMovie.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import <hpple/TFHpple.h>

@implementation GUMMovie

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"moviedbID" : @"id",
             @"theatricalReleaseDate" : @"release_date",
             @"title" : @"title",
             @"synopsis" : @"overview",
             @"imdbID" : @"imdb_id",
             @"posterPath" : @"poster_path",
             @"status" : @"status"
             };
}

+ (NSValueTransformer *)theatricalReleaseDateJSONTransformer{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    
    return [MTLValueTransformer transformerWithBlock:^NSDate *(NSString *dateString) {
        return [formatter dateFromString:dateString];
    }];
}

+ (NSValueTransformer *)statusJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^NSNumber *(NSString *status) {
        if([status isEqualToString:@"Released"]){
            return @(GUMReleased);
        }
        else{
            return @(GUMNotReleased);
        }
    }];
}

- (void)updateNetflixStatus{
    if (!self.rottenTomatoesURL){
        NSLog(@"This movie %@ needs a RottenTomatoes URL",self);
    }
    
    NSData *htmlData = [NSData dataWithContentsOfURL:self.rottenTomatoesURL];
    TFHpple *hppleParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    NSString *xpath = @"//tr[@id='netflixAffiliates']/td/a";
    NSArray *elements = [hppleParser searchWithXPathQuery:xpath];
    
    for(TFHppleElement *e in elements){
        if([[e.attributes valueForKey:@"class"] isEqualToString:@"streamNow"]){
            //movie is available on instant
            self.netflixStatus = GUMAvailable;
            NSString *netflixLink = [e.attributes valueForKey:@"href"];
            NSArray *components = [netflixLink componentsSeparatedByString:@"/"];
            self.netflixID = [components lastObject];
        }
    }
}

@end

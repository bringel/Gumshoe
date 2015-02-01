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

/**
 *  This method provides a dictionary that Mantle looks for when
 *  transforming JSON to an object. The keys of the dictionary are
 *  the names of the properties on the object, and the values are
 *  the names of the properties in the JSON object
 *
 *  @return a dictionary with object to JSON property mappings
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"rottenTomatoesID" : @"id",
             @"theatricalReleaseDate" : @"release_dates.theater",
             @"title" : @"title",
             @"synopsis" : @"synopsis",
             @"imdbID" : @"alternate_ids.imdb",
             @"posterURL" : @"posters.detailed",
             @"rottenTomatoesURL" : @"links.alternate"
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

+ (NSValueTransformer *)posterURLJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^NSURL *(NSString *url) {
        NSString *modifiedString = [url stringByReplacingOccurrencesOfString:@"tmb" withString:@"det"];
        return [NSURL URLWithString:modifiedString];
    }];
}

+ (NSValueTransformer *)ratingsJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^NSDictionary *(NSDictionary *ratingsData) {
        NSMutableDictionary *ratings = [[NSMutableDictionary alloc] init];
        [ratings setValue:[ratingsData valueForKey:@"critics_score"] forKey:@"criticScore"];
        [ratings setValue:[ratingsData valueForKey:@"audience_score"] forKey:@"audienceScore"];
        
        NSString *criticsRating = [ratingsData valueForKey:@"critics_rating"];
        NSString *audienceRating = [ratingsData valueForKey:@"audience_rating"];
        GUMRottenTomatoesRating critics;
        GUMRottenTomatoesRating audience;
        
        if([criticsRating isEqualToString:@"Certified Fresh"]){
            critics = GUMCertifiedFresh;
        }
        else if([criticsRating isEqualToString:@"Fresh"]){
            critics = GUMFresh;
        }
        else if([criticsRating isEqualToString:@"Rotten"]){
            critics = GUMRotten;
        }
        else{
            critics = -1;
        }
        
        if([audienceRating isEqualToString:@"Upright"]){
            audience = GUMUpright;
        }
        else if([audienceRating isEqualToString:@"Spilled"]){
            audience = GUMSpilled;
        }
        else{
            audience = -1;
        }
        
        [ratings setValue:@(critics) forKey:@"criticsRating"];
        [ratings setValue:@(audience) forKey:@"audienceRating"];
        
        return [ratings copy];
    }];
}
- (NSDictionary *)ratings{
    if(_ratings == nil){
        _ratings = [[NSDictionary alloc] init];
    }
    return _ratings;
}

- (NSMutableDictionary *)sourceStatuses{
    if(_sourceStatuses == nil){
        _sourceStatuses = [[NSMutableDictionary alloc] init];
    }
    return _sourceStatuses;
}

- (void)updateNetflixStatus{
    if (!self.rottenTomatoesURL){
        NSLog(@"This movie %@ needs a RottenTomatoes URL",self);
        return;
    }
    
    NSData *htmlData = [NSData dataWithContentsOfURL:self.rottenTomatoesURL];
    TFHpple *hppleParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    NSString *xpath = @"//tr[@id='netflixAffiliates']/td/a";
    NSArray *elements = [hppleParser searchWithXPathQuery:xpath];
    
    for(TFHppleElement *e in elements){
        if([[e.attributes valueForKey:@"class"] isEqualToString:@"streamNow"]){
            //movie is available on instant
            [self.sourceStatuses setValue:GUMAvailable forKey:@"netflixInstant"];
            NSString *netflixLink = [e.attributes valueForKey:@"href"];
            NSArray *components = [netflixLink componentsSeparatedByString:@"/"];
            self.netflixID = [components lastObject];
        }
    }
}

@end

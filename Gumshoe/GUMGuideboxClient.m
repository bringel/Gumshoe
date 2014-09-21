//
//  GUMGuideboxClient.m
//  Gumshoe
//
//  Created by Bradley Ringel on 9/21/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMGuideboxClient.h"
#import "GUMAppDelegate.h"

@interface GUMGuideboxClient()

@end

@implementation GUMGuideboxClient

+ (instancetype)sharedClient{
    static GUMGuideboxClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        GUMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSString *apiKey = [[delegate apiInfo] objectForKey:@"guidebox_key"];
        NSURL *baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://api-public.guidebox.com/v1.43/json/%@",apiKey]];
        client = [[GUMGuideboxClient alloc] initWithBaseURL:baseUrl sessionConfiguration:configuration];
    });
    return client;
}



@end

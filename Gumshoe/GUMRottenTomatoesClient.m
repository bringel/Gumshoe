//
//  VSRRottentTomatesClient.m
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMRottenTomatoesClient.h"
#import "GUMAppDelegate.h"
#import "Promise.h"

@interface GUMRottenTomatoesClient()

@end

@implementation GUMRottenTomatoesClient

+ (instancetype)sharedClient{
    static GUMRottenTomatoesClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[GUMRottenTomatoesClient alloc] init];
    });
    return client;
}

- (instancetype)init{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURL *baseUrl = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/"];
    self = [super initWithBaseURL:baseUrl sessionConfiguration:configuration];
    if(self){
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (NSString  *)_apiKey{
    GUMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [[appDelegate apiInfo] objectForKey:@"rottentomatoes_api_key"];
}

- (PMKPromise *)searchForMovieWithTitle:(NSString *)title{
    return [PMKPromise new:^(PMKPromiseFulfiller fulfill, PMKPromiseRejecter reject) {
        [self GET:@"movies.json" parameters:@{ @"q" : title, @"apikey" : [self _apiKey]}
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
              if(response.statusCode == 200){
                  NSDictionary *responseData = responseObject;
                  fulfill(responseData[@"movies"]);
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              reject(error);
          }];
    }];
}

@end

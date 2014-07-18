//
//  VSRRottentTomatesClient.m
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMRottenTomatesClient.h"
#import "GUMAppDelegate.h"

@interface GUMRottenTomatesClient()

@end

@implementation GUMRottenTomatesClient

+ (instancetype)sharedClient{
    static GUMRottenTomatesClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[GUMRottenTomatesClient alloc] init];
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

- (void)searchForMovieWithTitle:(NSString *)title success:(void (^)(NSArray *movieData))successBlock failure:(void (^)(NSError *error))failBlock{
    
    [self GET:@"movies.json" parameters:@{ @"q" : title, @"apikey" : [self _apiKey]}
      success:^(NSURLSessionDataTask *task, id responseObject) {
          NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
          if(response.statusCode == 200){
              NSDictionary *responseData = responseObject;
              successBlock(responseData[@"movies"]);
          }
    }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failBlock(error);
    }];
}

@end

//
//  VSRRottenTomatoesManager.m
//  Visor
//
//  Created by Bradley Ringel on 6/15/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "VSRRottenTomatoesClient.h"

@implementation VSRRottenTomatoesClient

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    __block VSRRottenTomatoesClient *manager;
    dispatch_once(&onceToken, ^{
        NSURL *base = [[NSURL alloc] initWithString:@"http://api.rottentomatoes.com/api/public/v1.0"];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[VSRRottenTomatoesClient alloc] initWithBaseURL:base sessionConfiguration:configuration];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    
    return manager;
}

- (NSString *)apiKey{
    NSDictionary *apiInformation = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"apikeys" withExtension:@"plist"]];
    
    return [apiInformation objectForKey:@"rottentomatoes_api_key"];
}

- (void)searchMoviesWithTitle:(NSString *)title completion:(void (^)(NSDictionary *))completion{
    
   [self GET:@"movies.json" parameters:@{@"q" : title, @"apikey" : self.apiKey}
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                        if(response.statusCode == 200){
                                            NSDictionary *responseData = responseObject;
                                            completion(responseData);
                                        }
            }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        NSLog(@"Error loading movies %@", error.localizedDescription);
            }]; 
}
@end

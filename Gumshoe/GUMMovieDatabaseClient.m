//
//  GUMMovieDatabaseClient.m
//  Gumshoe
//
//  Created by Bradley Ringel on 7/24/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//
// This is an AFNetworking client for themoviedb.org

#import "GUMMovieDatabaseClient.h"
#import "GUMAppDelegate.h"

@interface GUMMovieDatabaseClient()

- (NSString *)_apiKey;

@end

@implementation GUMMovieDatabaseClient

+ (instancetype)sharedClient{
    static GUMMovieDatabaseClient *client;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        client = [[GUMMovieDatabaseClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/"] sessionConfiguration:configuration];
        client.requestSerializer = [AFHTTPRequestSerializer serializer];
        client.responseSerializer = [AFJSONResponseSerializer serializer];
        [client GET:@" configuration" parameters:@{ @"api_key" : [client _apiKey]} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            if(response.statusCode == 200){
                NSDictionary *responseData = responseObject;
                client.posterBaseURL = [NSURL URLWithString:[responseData valueForKeyPath:@"images.base_url"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    });
    
    return client;
}

- (NSString *)_apiKey{
    
    GUMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [[appDelegate apiInfo] objectForKey:@"themoviedb_key"];
}

/*
- (NSURL *)posterBaseURL{
    
    if(_posterBaseURL == nil){
//        NSURLSessionDataTask *task = [self GET:@"configuration" parameters:@{@"api_key" : [self _apiKey]} success:^(NSURLSessionDataTask *task, id responseObject) {
//            if(((NSHTTPURLResponse *)task.response).statusCode == 200){
//                NSDictionary *responseData = responseObject;
//                NSLog(@"Response data: %@", responseData); 
//                _posterBaseURL = [responseData valueForKeyPath:@"images.base_url"];
//            }
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            
//        }];
//        while(task.state == NSURLSessionTaskStateRunning); //hacky way to stop this from returning
        //this should really do what's in the comments, but that request keeps crashing right now
        _posterBaseURL = [NSURL URLWithString:@"http://image.tmdb.org/t/p/original"];
    }
    return _posterBaseURL;
}
 */

- (void)searchForMovieWithTitle:(NSString *)title
                             success:(void (^)(NSArray *movieData))successBlock
                             failure:(void (^)(NSError *error))failureBlock{
    [self GET:@"search/movie" parameters:@{ @"api_key" : [self _apiKey], @"query" : title, @"search_type" : @"ngram"}
      success:^(NSURLSessionDataTask *task, id responseObject) {
          NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
          if(response.statusCode == 200){
              NSDictionary *responseData = responseObject;
              NSArray *movies = [responseData objectForKey:@"results"];
              successBlock(movies);
          }
          else{
              failureBlock([NSError errorWithDomain:@"Networking Error" code:response.statusCode userInfo:@{}]);
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failureBlock(error);
      }];
}

@end

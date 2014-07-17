//
//  VSRRottentTomatoesClientTestCase.m
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VSRRottenTomatesClient.h"
#import "OHHTTPStubs.h"
#import "OHHTTPStubsResponse+JSON.h"

@interface VSRRottenTomatoesClientTestCase : XCTestCase

@property (strong, nonatomic) VSRRottenTomatesClient *rtClient;
@property (strong, nonatomic) NSDictionary *apiResponse;

@end

@implementation VSRRottenTomatoesClientTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.rtClient = [VSRRottenTomatesClient sharedClient];
//    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *jsonPath = [documents stringByAppendingPathComponent:@"searchresults.json"];
    NSURL *jsonPath = [[NSBundle bundleForClass:[self class]] URLForResource:@"searchresult" withExtension:@"json"];
    
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonPath];
    self.apiResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        NSString *urlString = request.URL.description;
        if([urlString hasPrefix:@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=Toy+Story+3"]){
            return YES;
        }
        return NO;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithJSONObject:self.apiResponse statusCode:200 headers:@{}];
    }];
    [OHHTTPStubs setEnabled:YES];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [OHHTTPStubs removeAllStubs];
}

- (void)testSearch
{
    //test by search for Toy Story 3 since it's a good example that is unlikely to change
    //this test is really really fragile
    [self.rtClient searchForMovieWithTitle:@"Toy Story 3" success:^(NSArray *movieData) {
        XCTAssertEqualObjects(movieData, self.apiResponse, @"Error: API response not equal to saved value");
    } failure:^(NSError *error) {
        XCTFail(@"Error performing search %@", error);
    }];
}

- (void)testSearchConnection{
    [self.rtClient searchForMovieWithTitle:@"Toy Story 3" success:^(NSArray *movieData) {
        //just see if we got anything back from the server
        XCTAssertNotNil(movieData, @"Error: movie data is nil");
    } failure:^(NSError *error) {
        XCTFail(@"Error: Failure connecting to service %@", error);
    }];
}

@end

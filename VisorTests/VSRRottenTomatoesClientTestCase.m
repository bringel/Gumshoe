//
//  VSRRottentTomatoesClientTestCase.m
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VSRRottenTomatesClient.h"

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
    self.apiResponse = @{
        @"total": @(1),
        @"movies": @[@{
            @"id": @"770672122",
            @"title": @"Toy Story 3",
            @"year": @(2010),
            @"mpaa_rating": @"G",
            @"runtime": @(103),
            @"critics_consensus": @"",
            @"release_dates": @{
                @"theater": @"2010-06-18",
                @"dvd": @"2010-11-02"
            },
            @"ratings": @{
                @"critics_rating": @"Certified Fresh",
                @"critics_score": @(99),
                @"audience_rating": @"Upright",
                @"audience_score": @(89)
            },
            @"synopsis": @"\"Toy Story 3\" welcomes Woody, Buzz and the whole gang back to the big screen as Andy prepares to depart for college and his loyal toys find themselves in... daycare! These untamed tots with their sticky little fingers do not play nice, so it's all for one and one for all as plans for the great escape get underway. A few new faces-some plastic, some plush-join the adventure, including iconic swinging bachelor and Barbie's counterpart Ken, a thespian hedgehog named Mr. Pricklepants and a pink, strawberry-scented teddy bear called Lots-o'-Huggin' Bear.",
            @"posters": @{
                @"thumbnail": @"http://content6.flixster.com/movie/11/13/43/11134356_tmb.jpg",
                @"profile": @"http://content6.flixster.com/movie/11/13/43/11134356_tmb.jpg",
                @"detailed": @"http://content6.flixster.com/movie/11/13/43/11134356_tmb.jpg",
                @"original": @"http://content6.flixster.com/movie/11/13/43/11134356_tmb.jpg"
            },
            @"abridged_cast": @[@{
                @"name": @"Tom Hanks",
                @"id": @"162655641",
                @"characters": @[@"Woody"]
            }, @{
                @"name": @"Tim Allen",
                @"id": @"162655909",
                @"characters": @[@"Buzz Lightyear"]
            }, @{
                @"name": @"Joan Cusack",
                @"id": @"162655020",
                @"characters": @[@"Jessie the Cowgirl"]
            }, @{
                @"name": @"Ned Beatty",
                @"id": @"162672460",
                @"characters": @[@"Lots-o'-Huggin' Bear", @"Lotso"]
            }, @{
                @"name": @"Don Rickles",
                @"id": @"341817905",
                @"characters": @[@"Mr. Potato Head"]
            }],
            @"alternate_ids": @{
                @"imdb": @"0435761"
            },
            @"links": @{
                @"self": @"http://api.rottentomatoes.com/api/public/v1.0/movies/770672122.json",
                @"alternate": @"http://www.rottentomatoes.com/m/toy_story_3/",
                @"cast": @"http://api.rottentomatoes.com/api/public/v1.0/movies/770672122/cast.json",
                @"reviews": @"http://api.rottentomatoes.com/api/public/v1.0/movies/770672122/reviews.json",
                @"similar": @"http://api.rottentomatoes.com/api/public/v1.0/movies/770672122/similar.json"
            }
        }],
        @"links": @{
            @"self": @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=Toy+Story+3&page_limit=10&page=1"
        },
        @"link_template": @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q={search-term}&page_limit={results-per-page}&page={page-number}"
        };
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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

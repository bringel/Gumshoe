//
//  VSRListVCTestCase.m
//  Visor
//
//  Created by Bradley Ringel on 7/13/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GUMMovieListViewController.h"

@interface GUMListVCTestCase : XCTestCase

@property (nonatomic, strong) GUMMovieListViewController *listVC;
@end

@implementation GUMListVCTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.listVC = [[GUMMovieListViewController alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
//
//- (void)testPersistenceController{
//    XCTAssertNotNil(self.listVC.persitenceController, @"Persistence controller is nil!");
//    
//}
//
//- (void)testFetchedResultsController{
//    
//    XCTAssertNotNil(self.listVC.fetchedResultsController, @"Fetched Results Controller is nil!");
//}

@end

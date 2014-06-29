//
//  VSRStoreController.m
//  Visor
//
//  Created by Bradley Ringel on 6/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "VSRAppDelegate.h"
#import "VSRStoreController.h"
#import "MDMCoreData.h"
#import "VSRMovie.h"

@interface VSRStoreController ()

@property (nonatomic, strong) MDMPersistenceController *persistenceController;

@end

@implementation VSRStoreController

+ (instancetype)sharedController{
    static dispatch_once_t onceToken;
    __block VSRStoreController *controller;
    
    dispatch_once(&onceToken, ^{
        controller = [[VSRStoreController alloc] init];
    });
    
    return controller;
}

- (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (instancetype)init{
    self = [super init];
    if(self){
        NSURL *storeURL = [NSURL fileURLWithPath:[[self documentsDirectory] stringByAppendingPathComponent:@"Visor.sqlite"]];
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Visor" withExtension:@"momd"];
        self.persistenceController = [[MDMPersistenceController alloc] initWithStoreURL:storeURL modelURL:modelURL];
    }
    return self;
}

- (BOOL)addMovieWithMovieInfo:(NSDictionary *)movieInfo coverImage:(NSData *)imageData{
    __block BOOL success;
    VSRMovie *movie = [NSEntityDescription insertNewObjectForEntityForName:@"VSRMovie" inManagedObjectContext:self.persistenceController.managedObjectContext];
    movie.title = movieInfo[@"title"];
    movie.coverImage = imageData;
    movie.rottenTomatoesID = movieInfo[@"id"];

    [self.persistenceController saveContextAndWait:YES completion:^(NSError *error) {
        success = error ? false : true;
    }];
    return success;
}

@end

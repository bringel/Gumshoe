//
//  GUMUser.m
//  Gumshoe
//
//  Created by Bradley Ringel on 7/20/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMUser.h"

@implementation GUMUser

+ (instancetype)currentUser{
    static GUMUser *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *archivePath = [documentsDirectory stringByAppendingPathComponent:@"userArchive"];
        user = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
        
        if(!user){
            //there was nothing at the file path, create a new user
            user = [[GUMUser alloc] init];
        }
    });
    
    return user;
}

- (GUMMovieList *)movieList{
    if(_movieList == nil){
        _movieList = [[GUMMovieList alloc] init];
    }
    return _movieList;
}

- (void)saveUser{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *archivePath = [documentsDirectory stringByAppendingPathComponent:@"userArchive"];
    [NSKeyedArchiver archiveRootObject:self toFile:archivePath];
}

@end

//
//  GUMItemSearchClient.h
//  Gumshoe
//
//  Created by Bradley Ringel on 1/1/15.
//  Copyright (c) 2015 Bradley Ringel. All rights reserved.
//

@protocol GUMItemSearchClient <NSObject>

- (instancetype)sharedClient;

- (void)searchForItemWithTitle:(NSString *)title success:(void (^)(NSArray *))successBlock failure:(void (^)(NSError *))failureBlock;

@end
//
//  GUMItemSearchViewController.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GUMItemSearchViewController : UITableViewController

@property (strong, nonatomic) UISearchController *searchController;

- (IBAction)cancelSearch:(id)sender;
@end

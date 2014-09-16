//
//  VSRItemDetailViewController.m
//  Visor
//
//  Created by Bradley Ringel on 7/15/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMMovieDetailViewController.h"
#import "AsyncImageView.h"
#import "GUMMovie.h"
#import "MTLJSONAdapter.h"
#import "GUMMovieDatabaseClient.h"

@interface GUMMovieDetailViewController ()

@end

@implementation GUMMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //   self.posterImageView.imageURL = [[[GUMMovieDatabaseClient sharedClient] posterBaseURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", @"original", self.itemData[@"poster_path"]]];
   // self.titleLabel.text = [NSString stringWithFormat:@"%@ - (%@)", self.itemData[@"title"], self.itemData[@"year"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(id)sender{
    NSError *error;
   // GUMMovie *newMovie = [MTLJSONAdapter modelOfClass:[GUMMovie class] fromJSONDictionary:self.itemData error:&error];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

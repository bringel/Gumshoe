//
//  VSRTitleDetailViewController.m
//  Visor
//
//  Created by Bradley Ringel on 6/18/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "VSRTitleDetailViewController.h"
#import "VSRStoreController.h"

@interface VSRTitleDetailViewController ()

@end

@implementation VSRTitleDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.posterImageView.image = [UIImage imageWithData:self.titlePosterData];
    self.titleLabel.text = [self.titleData objectForKey:@"title"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTitle:(id)sender{
    VSRStoreController *controller = [VSRStoreController sharedController];
    [controller addMovieWithMovieInfo:self.titleData coverImage:self.titlePosterData];
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
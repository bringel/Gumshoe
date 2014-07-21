//
//  VSRItemDetailViewController.m
//  Visor
//
//  Created by Bradley Ringel on 7/15/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMItemDetailViewController.h"
#import "AsyncImageView.h"

@interface GUMItemDetailViewController ()

@end

@implementation GUMItemDetailViewController

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
    self.posterImageView.imageURL = [NSURL URLWithString: [self.itemData valueForKeyPath:@"posters.detailed"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ - (%@)", self.itemData[@"title"], self.itemData[@"year"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

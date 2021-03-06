//
//  GUMItemDetailViewController.h
//  Gumshoe
//
//  Created by Bradley Ringel on 7/15/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GUMMovieDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *synopsisTextView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) NSNumber *itemId;

- (IBAction)addItem:(id)sender;
@end

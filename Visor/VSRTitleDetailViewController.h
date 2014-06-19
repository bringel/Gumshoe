//
//  VSRTitleDetailViewController.h
//  Visor
//
//  Created by Bradley Ringel on 6/18/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSRTitleDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *titleData;
@property (nonatomic, strong) NSData *titlePosterData;

@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

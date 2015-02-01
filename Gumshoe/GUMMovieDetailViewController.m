//
//  GUMMovieDetailViewController.m
//  Gumshoe
//
//  Created by Bradley Ringel on 7/15/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMMovieDetailViewController.h"
#import "GUMMovie.h"
#import "MTLJSONAdapter.h"
#import "GUMMovieDatabaseClient.h"
#import "GUMUser.h"
#import "UIImageView+AFNetworking.h"
#import "GUMRottenTomatoesClient.h"
#import "Promise.h"

@interface GUMMovieDetailViewController ()

@property (strong, nonatomic) GUMMovie *movie;

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
    
    PMKPromise *promise = [[GUMRottenTomatoesClient sharedClient] getMovieInformation:self.itemId];
    promise.then(^(NSDictionary *movieData) {
        NSError *error;
        self.movie = [MTLJSONAdapter modelOfClass:[GUMMovie class] fromJSONDictionary:movieData error:&error];
        
        [self.posterImageView setImageWithURL: self.movie.posterURL];
        NSInteger component = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:self.movie.theatricalReleaseDate];
        self.titleLabel.text = [NSString stringWithFormat:@"%@ - (%ld)", self.movie.title, (long)component];
        self.synopsisTextView.text = self.movie.synopsis;
    }).then(^{
        [self.movie updateNetflixStatus];
    });
    promise.catch(^(NSError *error) {
        NSLog(@"Error %@", error);
    });
    
    self.addButton.layer.cornerRadius = 3.5f;
    self.addButton.layer.borderColor = self.addButton.tintColor.CGColor;
    self.addButton.layer.borderWidth = 1.0f;
    self.posterImageView.contentMode = UIViewContentModeScaleToFill;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(id)sender{
    GUMUser *currentUser = [GUMUser currentUser];
    
    [currentUser.movieList addMovie:self.movie];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)syncMovieWithRottenTomatoes:(GUMMovie *)movie{
    PMKPromise *promise = [[GUMRottenTomatoesClient sharedClient] searchForMovieWithTitle:movie.title];
    
    promise.then(^(NSArray *movieData) {
        for (NSDictionary *movieInfo in movieData) {
            if([movie.imdbID isEqualToString:[NSString stringWithFormat:@"tt%@",[movieInfo valueForKeyPath:@"alternate_ids.imdb"]]]){
                movie.rottenTomatoesID = [movieInfo valueForKey:@"id"];
                movie.rottenTomatoesURL = [NSURL URLWithString:[movieInfo valueForKeyPath:@"links.alternate"]];
            }
        }
    }).then(^{
        [movie updateNetflixStatus];
    });
    promise.catch(^(NSError *error) {
        NSLog(@"Error %@",error);
    });
    
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

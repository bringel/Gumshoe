//
//  VSRItemSearchViewController.m
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMItemSearchViewController.h"
#import "GUMRottenTomatesClient.h"
#import "GUMItemDetailViewController.h"
#import "GUMMovieTableViewCell.h"
#import "AsyncImageView.h"

@interface GUMItemSearchViewController () <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation GUMItemSearchViewController

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
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"GUMMovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"movieCell"];
    self.searchDisplayController.searchResultsTableView.delegate = self;
    self.searchDisplayController.searchResultsTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GUMMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    
    //do some setup here
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-mm-dd";
    
    NSDictionary *movie = self.searchResults[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    
//    NSURL *imageUrl = [movie valueForKeyPath:@"posters.thumbnail"];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfiguration:@"background"]];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:imageUrl];
//    [dataTask resume];
    cell.posterImageView.imageURL = [NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]];

    NSDate *theaterRelease = [dateFormatter dateFromString:[movie valueForKeyPath:@"release_dates.theater"]];
                              NSDate *dvdRelease = [dateFormatter dateFromString:[movie valueForKeyPath:@"release_dates.dvd"]];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    //TODO: Set the locale information
    cell.detailsLabel.text = [NSString stringWithFormat:@"Theaters - %@ | DVD - %@",[dateFormatter stringFromDate:theaterRelease],[dateFormatter stringFromDate:dvdRelease]];
    return cell;
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [[GUMRottenTomatesClient sharedClient] searchForMovieWithTitle:searchString success:^(NSArray *movieData) {
        self.searchResults = movieData;
        [self.searchDisplayController.searchResultsTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Got an error %@", error);
    }];
    return NO;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showItemDetails" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSDictionary *movieData = self.searchResults[self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow.row];
    GUMItemDetailViewController *itemDetailVC = segue.destinationViewController;
    itemDetailVC.itemData = movieData;
    
}

@end

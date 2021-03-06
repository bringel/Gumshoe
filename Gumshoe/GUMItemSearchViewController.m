//
//  GUMItemSearchViewController.m
//  Gumshoe
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMItemSearchViewController.h"
#import "GUMRottenTomatoesClient.h"
#import "GUMMovieDatabaseClient.h"
#import "GUMMovieDetailViewController.h"
#import "GUMMovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Promise.h"

@interface GUMItemSearchViewController () <UISearchBarDelegate, UISearchResultsUpdating>

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
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    UISearchBar *searchBar = self.searchController.searchBar;
    self.tableView.tableHeaderView = searchBar;
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(searchBar.frame.origin.x, searchBar.frame.origin.y, searchBar.frame.size.width, 44.0);
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
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDictionary *movie = self.searchResults[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    
    if([movie valueForKey:@"poster_path"] != [NSNull null]){
//        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.posterImageView]; //in case this cell had other images loading
        cell.posterImageView.image = nil;
        NSURL *posterURL = [NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]];
        [cell.posterImageView setImageWithURL: posterURL];
    }

    NSDate *theaterRelease = [dateFormatter dateFromString:[movie valueForKeyPath:@"release_dates.theater"]];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    //TODO: Set the locale information
    cell.detailsLabel.text = [NSString stringWithFormat:@"In Theaters - %@",[dateFormatter stringFromDate:theaterRelease]];
    return cell;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchText = searchController.searchBar.text;
    PMKPromise *promise = [[GUMRottenTomatoesClient sharedClient] searchForMovieWithTitle:searchText];
    promise.then(^(NSArray *movieData) {
        self.searchResults = movieData;
        [self.tableView reloadData];
    });
    promise.catch(^(NSError *error){
        NSLog(@"Got an error %@",error);
    });
}


#pragma mark - UISearchBarDelegate

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    [[GUMMovieDatabaseClient sharedClient] searchForMovieWithTitle:searchText success:^(NSArray *movieData) {
//        self.searchResults = movieData;
//        [self.tableView reloadData];
//    } failure:^(NSError *error){
//        NSLog(@"Got an error %@",error);
//    }];
//}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    [[GUMMovieDatabaseClient sharedClient] searchForMovieWithTitle:searchBar.text success:^(NSArray *movieData) {
//        self.searchResults = movieData;
//        [self.tableView reloadData];
//    } failure:^(NSError *error){
//        NSLog(@"Got an error %@",error);
//    }];
//}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showMovieDetails" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
#pragma mark - Navigation

- (IBAction)cancelSearch:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showMovieDetails"]){
        NSDictionary *movieData = self.searchResults[self.tableView.indexPathForSelectedRow.row];
        GUMMovieDetailViewController *itemDetailVC = segue.destinationViewController;
        itemDetailVC.itemId = movieData[@"id"];
        
        //stop the uiimageviews from loading up images here since they are going off screen
        for(GUMMovieTableViewCell *cell in self.tableView.visibleCells){
            [cell.posterImageView cancelImageRequestOperation];
        }
    }
    
}

@end

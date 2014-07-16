//
//  VSRItemSearchViewController.m
//  Visor
//
//  Created by Bradley Ringel on 7/14/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "VSRItemSearchViewController.h"
#import "VSRRottenTomatesClient.h"

@interface VSRItemSearchViewController () <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation VSRItemSearchViewController

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
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //do some setup here
    NSDictionary *movie = self.searchResults[indexPath.row];
    cell.textLabel.text = movie[@"title"];
    return cell;
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [[VSRRottenTomatesClient sharedClient] searchForMovieWithTitle:searchString success:^(NSArray *movieData) {
        self.searchResults = movieData;
        [self.searchDisplayController.searchResultsTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Got an error %@", error);
    }];
    return NO;
}

#pragma mark - UITableViewDelegate



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

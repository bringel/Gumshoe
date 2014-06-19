//
//  VSRTitleSearchViewController.m
//  Visor
//
//  Created by Bradley Ringel on 6/15/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "VSRTitleSearchViewController.h"
#import "VSRRottenTomatoesClient.h"
#import "VSRTitleCell.h"
#import "VSRTitleDetailViewController.h"


@interface VSRTitleSearchViewController () <UISearchBarDelegate>

@property (nonatomic, strong) VSRRottenTomatoesClient *rottenTomatoesClient;
@property (nonatomic, strong) NSArray *searchResults;
@end

@implementation VSRTitleSearchViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView registerNib:[UINib nibWithNibName:@"VSRTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"titleCell"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (VSRRottenTomatoesClient *)rottenTomatoesClient{
    if(_rottenTomatoesClient == nil){
        _rottenTomatoesClient = [VSRRottenTomatoesClient sharedManager];
    }
    return _rottenTomatoesClient;
}

- (NSArray *)searchResults{
    if(_searchResults == nil){
        _searchResults = [[NSArray alloc] init];
    }
    return _searchResults;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if([searchBar isEqual:self.searchBar]){
        NSString *searchString = searchBar.text;
        if([[searchBar.scopeButtonTitles objectAtIndex:searchBar.selectedScopeButtonIndex] isEqualToString:@"Movies"]){
            [self.rottenTomatoesClient searchMoviesWithTitle:searchString completion:^(NSDictionary *responseData) {
                self.searchResults = [responseData objectForKey:@"movies"];
                [self.searchDisplayController.searchResultsTableView reloadData];
            }];
        }
    }
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:@"VSRTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"titleCell"];
    tableView.rowHeight = 62.0;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VSRTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
    cell.posterImageView.image = nil;
    
    // Configure the cell...
    NSString *posterURLString = [[[self.searchResults objectAtIndex:indexPath.row] objectForKey:@"posters"] objectForKey:@"original"];
    NSURL *posterURL = [NSURL URLWithString:posterURLString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:posterURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(((NSHTTPURLResponse *)response).statusCode == 200){
            NSLog(@"Got image data %@",response.URL);
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.posterImageData = data;
            });
            //[self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
    
    [task resume];
    cell.titleLabel.text = [[self.searchResults objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showTitleDetails" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showTitleDetails"]){
        VSRTitleDetailViewController *detailVC = (VSRTitleDetailViewController *)segue.destinationViewController;
        NSIndexPath *index = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        NSDictionary *titleData = [self.searchResults objectAtIndex:index.row];
        VSRTitleCell *cell = (VSRTitleCell *)[self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:index];
        detailVC.titleData = titleData;
        detailVC.titlePosterData = cell.posterImageData;
    }
}


@end

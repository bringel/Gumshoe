//
//  VSRListViewController.m
//  Visor
//
//  Created by Bradley Ringel on 7/13/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "GUMListViewController.h"
//#import "MDMCoreData.h"
#import "GUMUser.h"
#import "GUMMovie.h"
#import "HMSegmentedControl.h"

@interface GUMListViewController ()

//@property (strong, nonatomic) HMSegmentedControl *segmentedControl;

@property (strong, nonatomic) GUMUser *user;
@end

@implementation GUMListViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (GUMUser *)user{
    if(_user == nil){
        _user = [GUMUser currentUser];
    }
    return _user;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(showSettings:)];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAdd:)];

    self.navigationItem.leftBarButtonItem = settingsItem;
    self.navigationItem.rightBarButtonItem = addItem;
    NSArray *controlItems = @[@"Movies", @"TV Shows", @"Video Games", @"Books"];
    [self _setupFilterSelectionControl:controlItems];
}

- (void)_setupFilterSelectionControl:(NSArray *)controlItems
{
    self.filter.sectionTitles = controlItems;
    self.filter.font = [UIFont systemFontOfSize:14.0];
    self.filter.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.filter.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
   
    self.filter.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    //add a one pixel border to the bottom. because it looks nice.
    CALayer *borderLayer = [[CALayer alloc] init];
    borderLayer.frame = CGRectMake(0, 39, self.filter.frame.size.width, 1.0f);
    borderLayer.backgroundColor = self.filter.selectionIndicatorColor.CGColor;
    [self.filter.layer addSublayer:borderLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (NSFetchedResultsController *)fetchedResultsController{
//    if(_fetchedResultsController == nil){
//        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"GUMMovie"];
//        NSSortDescriptor *sortDiscriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//        fetchRequest.sortDescriptors = @[sortDiscriptor];
//        _fetchedResultsController = [[NSFetchedResultsController alloc]
//                                     initWithFetchRequest:fetchRequest
//                                     managedObjectContext:self.persitenceController.managedObjectContext
//                                     sectionNameKeyPath:nil
//                                     cacheName:nil];
//        _fetchedResultsController.delegate = self;
//        
//    }
//    
//    return _fetchedResultsController;
//}
//
//- (MDMPersistenceController *)persitenceController{
//    if(_persitenceController == nil){
//        NSURL *storeURL = [NSURL fileURLWithPath:[[self _documentsDirectory] stringByAppendingPathComponent:@"visor.sqlite"]];
//        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Visor" withExtension:@"momd"];
//        _persitenceController = [[MDMPersistenceController alloc] initWithStoreURL:storeURL modelURL:modelURL];
//    }
//    return _persitenceController;
//}
//
//- (NSString *)_documentsDirectory {
//    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//}
//
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return self.fetchedResultsController.sections.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
//    return [sectionInfo numberOfObjects];
    return [self.user.movieList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    // Configure the cell...
    GUMMovie *currentMovie = [self.user.movieList movieAtIndex:indexPath.row];
    
    cell.textLabel.text = currentMovie.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", currentMovie.moviedbID];
    return cell;
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
 
- (void)showSettings:(id)sender{
    
}

- (void)showFilter:(id)sender{
    
}

- (void)showAdd:(id)sender{
    [self performSegueWithIdentifier:@"showAddViewController" sender:self];
}
 

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

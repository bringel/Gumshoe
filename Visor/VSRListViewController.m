//
//  VSRListViewController.m
//  Visor
//
//  Created by Bradley Ringel on 7/13/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "VSRListViewController.h"
#import "MDMCoreData.h"

@interface VSRListViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation VSRListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(showSettings:)];
    UIBarButtonItem *filterItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(showFilter:)];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAdd:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.navigationItem.leftBarButtonItem = settingsItem;
    self.navigationItem.rightBarButtonItems = @[addItem,flexibleSpace,filterItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)fetchedResultsController{
    if(_fetchedResultsController == nil){
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"VSRMovie"];
        NSSortDescriptor *sortDiscriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        fetchRequest.sortDescriptors = @[sortDiscriptor];
        _fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest
                                     managedObjectContext:self.persitenceController.managedObjectContext
                                     sectionNameKeyPath:nil
                                     cacheName:nil];
        _fetchedResultsController.delegate = self;
        
    }
    
    return _fetchedResultsController;
}

- (MDMPersistenceController *)persitenceController{
    if(_persitenceController == nil){
        NSURL *storeURL = [NSURL fileURLWithPath:[[self _documentsDirectory] stringByAppendingPathComponent:@"visor.sqlite"]];
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Visor" withExtension:@"momd"];
        _persitenceController = [[MDMPersistenceController alloc] initWithStoreURL:storeURL modelURL:modelURL];
    }
    return _persitenceController;
}

- (NSString *)_documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
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
    
}
 

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

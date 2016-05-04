//
//  PlayerViewController.m
//  MTGApplication
//
//  Created by Pablo on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "PlayerViewController.h"
#import "Player.h"
#import "PlayerStore.h"
#import "PlayerCell.h"
#import "SortViewController.h"

@interface PlayerViewController ()
@end

@implementation PlayerViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.tableView reloadData];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Get the sorting mode from the player store
    NSString* sorter =[PlayerStore sharedStore].sortingMode;
    [self getEverything:sorter];

    [self.tableView reloadData];
}

//Method to fetch data from the coredata
-(void)getEverything:(NSString*) sorter{
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    NSSortDescriptor *sortDescriptor = NULL;
    //Sort based on the sortingMode
    if([sorter isEqualToString:@"pointsA"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"points" ascending:YES];
    else if([sorter isEqualToString:@"pointsD"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"points" ascending:NO];
    else if([sorter isEqualToString:@"firstA"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    else if([sorter isEqualToString:@"firstD"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:NO];
    else if([sorter isEqualToString:@"lastA"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"lastName" ascending:YES];
    else if([sorter isEqualToString:@"lastD"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"lastName" ascending:NO];
    else if([sorter isEqualToString:@"dciA"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"dci" ascending:YES];
    else if([sorter isEqualToString:@"dciD"])
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"dci" ascending:NO];
    else
        sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    
    NSArray* sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    //Set the descriptors
    [fetchRequest setSortDescriptors:sortDescriptors];
    //Now execute the request
    self.playerData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //Clear the store
    [[PlayerStore sharedStore] clearStore];
    //Populate the stroe
    for(int i = 0; i < self.playerData.count; i++){
        NSManagedObject *player = [self.playerData objectAtIndex:i];
        [[PlayerStore sharedStore] createPlayerwithFirst:[player valueForKey:@"firstName"] andLast:[player valueForKey:@"lastName"]  withDCI:[player valueForKey:@"dci"]withPoints:[player valueForKey:@"points"]withImage:[player valueForKey:@"picture"] ];
    }
}
//open the detail when a row is selected
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PlayerDetailViewController * detailViewController = [[PlayerDetailViewController alloc]initForNewPlayer:NO];
    NSArray* players = [[PlayerStore sharedStore] allPlayers];
    Player* selectedPlayer = players[indexPath.row];
    detailViewController.player = selectedPlayer;
    NSManagedObject *selectedPlayer2 = [self.playerData objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    detailViewController.playerDataObject = selectedPlayer2;

    [self.navigationController pushViewController:detailViewController animated:YES];
}
//call when the sort button is clicked, bring up the view controller
-(IBAction)sortTable:(id)sender{
    SortViewController * sortViewCont = [[SortViewController alloc]init];
    //sortViewCont.modalPresentationStyle = UIModalPresentationFormSheet;
    //sortViewCont.preferredContentSize = CGSizeMake(219, 312);
    
    [self presentViewController:sortViewCont animated:YES completion:nil];
    
}
//Action to add new player
-(IBAction)addNewItem:(id)sender{
    Player* newPlayer = [[PlayerStore sharedStore] createPlayer];

    PlayerDetailViewController* detailViewController = [[PlayerDetailViewController alloc]initForNewPlayer:YES];
    detailViewController.player = newPlayer;
    detailViewController.dismissBlock = ^{
        NSString* sorter =[PlayerStore sharedStore].sortingMode;
        //Reload the store
        [self getEverything:sorter];
        //Make sure the view reloads
        [self.tableView reloadData];
    };
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:detailViewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];
}


- (instancetype)init{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        [PlayerStore sharedStore].sortingMode = @"Default";
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Player List";
        //Add the butttons
        UIBarButtonItem *bbi= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        UIBarButtonItem *bbi2= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(sortTable:)];
        // navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
        navItem.rightBarButtonItems = @[bbi, bbi2];
        self.tabBarItem.title = @"Players";
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Commenting this line out to add custom cells
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //Load the custom cell xib
    UINib *nib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
    
    //Register nib, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PlayerCell"];
     
  //  UIView *header = self.headerView;
    //[self.tableView setTableHeaderView:header];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        [PlayerStore sharedStore].sortingMode = @"Default";
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Player List";
        UIBarButtonItem *bbi= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        UIBarButtonItem *bbi2= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(sortTable:)];
       // navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
        navItem.rightBarButtonItems = @[bbi, bbi2];
        self.tabBarItem.title = @"Players";
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return [[[PlayerStore sharedStore]allPlayers]count];
}
//Handles deleting a player
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)
    editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
     NSManagedObjectContext *context = [self managedObjectContext];
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSArray* players = [[PlayerStore sharedStore]allPlayers];
        Player* player = players[indexPath.row];
        // Delete object from database
        [context deleteObject:[self.playerData objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [[PlayerStore sharedStore]removePlayer:player];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Commenting out for custom cells
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    //Get a new or recycled cell
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell" forIndexPath:indexPath];
    NSArray *players = [[PlayerStore sharedStore] allPlayers];
    Player *player = players[indexPath.row];
    //cell.textLabel.text = [player dci];
    //Configue the cell with the Player
    NSString *firstLast = player.firstName;
    firstLast = [firstLast stringByAppendingString:@" "];
    firstLast = [firstLast stringByAppendingString:player.lastName];
    cell.firstNameTextField.text = firstLast;
    cell.dciTextField.text = player.dci;
    //NSString *points = [NSNumber Player.points]; --hV
    cell.pointsTextField.text = [player.points stringValue];
    cell.profileImage.image = player.thumbnail;
    //cell.pointsTextField.text = @"0";
    return cell;
}

//4/29/16-----Making row height larger
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}



@end

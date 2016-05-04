//
//  LeaderboardTableViewController.m
//  MTGApplication
//
//  Created by Vania Jarquin on 4/27/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "LeaderboardTableViewController.h"
#import "PlayerStore.h"
#import "Player.h"
#import "PlayerCell.h"

@interface LeaderboardTableViewController ()

@end

@implementation LeaderboardTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(instancetype)init
{
    //Call the superclass' designated initializr
    self = [super initWithStyle:UITableViewStylePlain];
    /*if(self){
        for (int i=0; i<5; i++){
            [[PlayerStore sharedStore] createPlayer];
        
     
    }*/
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView registerClass:UITableViewCell forCellReuseIdentifier:@"UITableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Load the custom cell xib
    UINib *nib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
    
    //Register nib, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PlayerCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle: nibBundleOrNil];
    if(self){
        self.tabBarItem.title = @"Leaderboard";
        self.tabBarItem.image = [UIImage imageNamed:@"News-25.png"];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [[[PlayerStore sharedStore] allPlayers] count];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Commenting out for custom cells
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    //Get a new or recycled cell
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell" forIndexPath:indexPath];
    
    NSArray *players = [[PlayerStore sharedStore] allPlayers];
    
    //cell.textLabel.text = [player dci];
    
    
    //SORTING here
    NSArray *descriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO]];
    players = [players sortedArrayUsingDescriptors:descriptor];
    
    //Configue the cell with the Player
    Player *player = players[indexPath.row];
    
    
    //4--29 Adding a number to represent the place RANK
    NSString *place = @"";
    NSInteger row = indexPath.row;
    for (int i=0; i <= row; i++)
    {
        place = [NSString stringWithFormat:@"%i", (i+1)];
    }
    NSString *firstLast = place;
    firstLast = [firstLast stringByAppendingString:@". "];
    firstLast = [firstLast stringByAppendingString:player.firstName];
    firstLast = [firstLast stringByAppendingString:@" "];
    firstLast = [firstLast stringByAppendingString:player.lastName];
    cell.firstNameTextField.text = firstLast;
    //
    
    //cell.dciTextField.text = player.dci; //4/29--NO POINTS DISPLAY
    cell.dciTextField.text = @"";
    //NSString *points = [NSNumber Player.points]; --hV
    cell.pointsTextField.text = [player.points stringValue];
    //cell.pointsTextField.text = @"0";
    cell.profileImage.image = player.thumbnail;
    return cell;
}

//4/29/16-----Making row height larger
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  PodsViewController.m
//  MTGApplication
//
//  Created by Whitney Walters on 5/3/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "PodsViewController.h"
#import "TournamentViewController.h"
#import "LeaderboardTableViewController.h"
#import "PlayerStore.h"
#import "Player.h"
#import "PlayerCell.h"
#import "PodsViewController.h"
#import "PodDetailViewController.h"


@interface PodsViewController ()
{
    NSInteger roundCount;
    NSInteger podCount;
    NSMutableArray *playerNameForPods;
    Player *player1;
    Player *player2;
    Player *player3;
    Player *player4;
}

@property (strong, nonatomic) IBOutlet UIView *PodsView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)next:(id)sender;
- (IBAction)end:(id)sender;


@end

@implementation PodsViewController

@synthesize playerList;


//Load the view
- (void)viewDidLoad {
    [super viewDidLoad];

    
    // created a array of players that are passed in
    playerNameForPods = [[NSMutableArray alloc]init];
    roundCount = 1;
    NSLog(@"inside view did load");
    if([playerList count] % 4 ==0)
    {
        podCount = [playerList count] / 4;
        [self arrangeFour];
        
    }
    else if([playerList count] % 3 ==0)
    {
        podCount = [playerList count] / 3;
//        [self arrangeFour];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)arrangeThree
{
    NSArray *players = [[PlayerStore sharedStore] allPlayers];
    NSArray *descriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO]];
    players = [players sortedArrayUsingDescriptors:descriptor];
    
    for (int i = 0; i < podCount; i++) {
        int x = 0;
        Player *player1 = players[x];
        Player *player2 = players[[players count]-1];
        Player *player3 = players[x+1];
        NSLog(@"Entered arrange 3");
        NSString *pod = [NSString stringWithFormat:@"%@ %@, %@ %@, %@ %@" , player1.firstName,player1.lastName,player2.firstName,player2.lastName,player3.firstName,player3.lastName];
        [playerNameForPods addObject:pod];
    }

}

// sets the four players into a new string

-(void)arrangeFour
{
    NSArray *players = [[PlayerStore sharedStore] allPlayers];
    NSArray *descriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO]];
    players = [players sortedArrayUsingDescriptors:descriptor];
    
    for (int i = 0; i < podCount; i++) {
        int x = (int)roundCount -1;
        player1 = players[[self checkValues:x]];
        player2 = players[[self checkValues:x+1]];
        player3 = players[[self checkValues:x+2]];
        player4 = players[[self checkValues:x+3]];
        NSLog(@"Entered arrange 4");
        NSString *pod = [NSString stringWithFormat:@"%@ %@ vs %@ %@ vs %@ %@ vs %@ %@" , player1.firstName,player1.lastName,player2.firstName,player2.lastName,player3.firstName,player3.lastName,player4.firstName,player4.lastName];
        [playerNameForPods addObject:pod];
    }
}


//sets the int values
-(int)checkValues: (int)input
{
    if(input > [playerList count] -1)
    {
        return 0;
    }
    else
    {
        return input;
    }
}

- (IBAction)next:(id)sender {
    roundCount++;
    [self.myTableView reloadData];
    
}


- (IBAction)end:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
    }
    cell.textLabel.text = [playerNameForPods objectAtIndex:(int)indexPath.row];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [playerNameForPods count];
    
}

-(NSInteger) numberOfSectionsIntableView:(UITableView *) tableview
{
    return 1;
}

-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PodDetailViewController* detailViewController = [[PodDetailViewController alloc]init];
    
    detailViewController.player1 = player1;
    detailViewController.player2 = player2;
    detailViewController.player3 = player3;
    detailViewController.player4 = player4;
    
    
    [self presentViewController:detailViewController animated:YES completion:nil];
    
    
}
@end

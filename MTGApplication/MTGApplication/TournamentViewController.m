//
//  TournamentViewController.m
//  MTGApplication
//
//  Created by Whitney Walters on 5/3/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "TournamentViewController.h"
#import "LeaderboardTableViewController.h"
#import "PlayerStore.h"
#import "Player.h"
#import "PlayerCell.h"
#import "PodsViewController.h"
@interface TournamentViewController ()

@property (strong, nonatomic) IBOutlet UIView *TournamentView;
- (IBAction)Select:(id)sender;
- (IBAction)Start:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end


@implementation TournamentViewController

{
    BOOL isEditing;
    NSMutableArray *playerList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    playerList = [[NSMutableArray alloc]init];
    
    UINib *nib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
    
    //Register nib, which contains the cell
    [self.myTableView registerNib:nib forCellReuseIdentifier:@"PlayerCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//creates the selection check box fields
- (IBAction)Select:(id)sender {
    
    if(isEditing)
    {
        [self setEditing:NO animated:YES];
        isEditing = false;
    }
    else
    {
        [self setEditing:YES animated:YES];
        isEditing = true;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.myTableView setEditing:editing animated:animated];
}



-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    NSLog(@"%ld", (long)indexPath.row);
    if(isEditing)
    {
        NSString *player = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        [playerList addObject:player];
    }

   
    
}
-(void)tableView:(UITableView *) tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    //fix no element in
    if(isEditing)
    {
        [playerList removeObjectAtIndex:indexPath.row];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[PlayerStore sharedStore]allPlayers]count];
 
}

-(NSInteger) numberOfSectionsIntableView:(UITableView *) tableview
{
    return 1;
}



- (IBAction)Start:(id)sender {
    
    // start tournament if there are 4 players
    
    if([playerList count] != 4)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Select four memebers to participate!"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else{
        PodsViewController* detailViewController = [[PodsViewController alloc]init];
        detailViewController.playerList = playerList;
        
        
        [self presentViewController:detailViewController animated:YES completion:nil];
    }
    
}

//4/29/16-----Making row height larger
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //Commenting out for custom cells
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    //Get a new or recycled cell
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell" forIndexPath:indexPath];
    
    NSArray *players = [[PlayerStore sharedStore] allPlayers];
    
    //cell.textLabel.text = [player dci];
    
    //Configue the cell with the Player
    Player *player = players[indexPath.row];
    
    

    NSString *firstLast = player.firstName;
    firstLast = [firstLast stringByAppendingString:@" "];
    firstLast = [firstLast stringByAppendingString:player.lastName];
    cell.firstNameTextField.text = firstLast;
    //
    cell.dciTextField.text = @"";
    //NSString *points = [NSNumber Player.points]; --hV
    cell.pointsTextField.text = [player.points stringValue];
    //cell.pointsTextField.text = @"0";
    cell.profileImage.image = player.thumbnail;
    return cell;
}
@end

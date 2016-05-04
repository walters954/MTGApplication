//
//  PodDetailViewController.h
//  MTGApplication
//
//  Created by Whitney Walters on 5/3/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PodsViewController.h"
#import "TournamentViewController.h"
#import "LeaderboardTableViewController.h"
#import "PlayerStore.h"
#import "Player.h"
#import "PlayerCell.h"
#import "PodsViewController.h"
#import "PodDetailViewController.h"

@interface PodDetailViewController : UIViewController

@property (strong, nonatomic) Player *player1;
@property (strong, nonatomic) Player *player2;
@property (strong, nonatomic) Player *player3;
@property (strong, nonatomic) Player *player4;

@end

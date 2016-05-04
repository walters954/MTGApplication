//
//  PlayerDetailViewController.h
//  MTGApplication
//
//  Created by Pablo on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Player;
@interface PlayerDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dciTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointsTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (instancetype) initForNewPlayer:(BOOL)isNew;
//- (IBAction)clickSave:(id)sender;
@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic,strong)Player* player;
@property (strong) NSManagedObject *playerDataObject;
@end

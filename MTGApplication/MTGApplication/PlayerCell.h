//
//  PlayerCell.h
//  MTGApplication
//
//  Created by Vania Jarquin on 4/28/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *dciTextField;
@property (weak, nonatomic) IBOutlet UILabel *pointsTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

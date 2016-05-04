//
//  Player.h
//  MTGApplication
//
//  Created by Pablo on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

// 4/29
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
//#import "ImageStore.h"

@interface Player : NSObject
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* dci;
@property (nonatomic, strong) NSNumber* points;
@property (nonatomic, copy) NSString* imageKey;
//4/29 -- 
@property (strong,nonatomic) UIImage *thumbnail;

@end

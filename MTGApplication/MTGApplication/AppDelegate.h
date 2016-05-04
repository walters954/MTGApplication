//
//  AppDelegate.h
//  MTGApplication
//
//  Created by Pablo on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UIViewController *viewController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end


//
//  PlayerStore.h
//  MTGApplication
//
//  Created by Pablo on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;

@interface PlayerStore : NSObject
{
    NSMutableArray *allPlayers;
}
@property BOOL isSorted;
@property (nonatomic,strong)NSString* sortingMode;
+ (instancetype) sharedStore;
- (NSArray *)allPlayers;
- (Player *)createPlayerwithFirst:(NSString*)first andLast:(NSString*)last withDCI:(NSString*)dci withPoints:(NSNumber*) points withImage:(NSData*)picture;
- (Player *)createPlayer;
- (void)sortStoreBy:(NSString*)sort;
- (void)clearStore;
- (void)removePlayer:(Player *)p;
//- (void)movePlayerAtIndex:(int)from toIndex:(int)to;
//- (NSString *)playerArchivePath;
//- (BOOL)saveChanges;
@end

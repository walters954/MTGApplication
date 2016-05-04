//
//  PlayerStore.m
//  MTGApplication
//
//  Created by Pablo, Vania, Warren on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "PlayerStore.h"
#import "Player.h"
#import "ImageStore.h"
@interface PlayerStore()
@property (nonatomic) NSMutableArray *privatePlayers;
@end
@implementation PlayerStore

+ (PlayerStore *)sharedStore
{
    static PlayerStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}
-(void)clearStore{
    [self.privatePlayers removeAllObjects];
}
-(void)sortStoreBy:(NSString *)sort{
    self.sortingMode = sort;
}
- (id)init
{
    self = [super init];
    if (self) {
        _privatePlayers = [[NSMutableArray alloc] init];
        self.isSorted = false;
        
    }
    
    return self;
}

- (NSArray *)allPlayers
{
    return self.privatePlayers;
}
//create a default playrt
-(Player*)createPlayer{
    Player* p = [[Player alloc] init];
    p.firstName = @"";
    p.lastName = @"";
    p.dci = @"0000000000";
    p.points = [NSNumber numberWithInt:0];
    [self.privatePlayers addObject:p];
    return p;
}
//Create a player and initialize it with passed parameters
- (Player *)createPlayerwithFirst:(NSString*)first andLast:(NSString*)last withDCI:(NSString*)dci withPoints:(NSNumber*) points withImage:(NSData*)picture;
{
    Player* p = [[Player alloc] init];
    p.firstName = first;
    p.lastName = last;
    p.dci = dci;
    p.points = points; //testing sorting
    p.thumbnail = [UIImage imageWithData:picture];;
    [self.privatePlayers addObject:p];
    return p;
}
//remove a player
- (void)removePlayer:(Player *)p
{
    //NSString *key = p.imageKey;
   // [[ImageStore sharedStore] deleteImageForKey:key];
   
    [self.privatePlayers removeObjectIdenticalTo:p];
}
//




@end

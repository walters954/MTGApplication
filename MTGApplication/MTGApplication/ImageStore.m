//
//  ImageStore.m
//  MTGApplication
//
//  Created by Vania Jarquin on 4/28/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "ImageStore.h"
@interface ImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation ImageStore

+(instancetype)sharedStore
{
    static ImageStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}
-(instancetype) init
{
    [NSException raise:@"Singleton" format:@"Use +[ImageStore sharedStore]"];
    return nil;
}
-(instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)setImage: (UIImage *)image forKey:(NSString *)key
{
    //[[self.dictionary] setObject:image forKey:key];
    //SHORTHAND
    self.dictionary[key] = image;
}
-(UIImage *)imageForKey:(NSString *)key
{
    //return [self.dictionary objectForKey:key];
    return self.dictionary[key];
}
-(void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end

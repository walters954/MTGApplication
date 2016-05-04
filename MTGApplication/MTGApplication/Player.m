//
//  Player.m
//  MTGApplication
//
//  Created by Pablo on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize firstName,lastName,dci,points;

//designated initializer pg225
/*
-(instancetype)*/

-(instancetype)initWithfirstName:(NSString *)first lastName:(NSString *)last dci:(NSString *)dciN{
    self = [super init];
    if (self){
        //give instance vars itinital values
        first = firstName;
        last = lastName;
        dciN = dci;
        
        //create unique object & get its string rep
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _imageKey = key;
    }
    
    //return address of the newly initialzed object
    return self;
}

- (id)init
{
    return [self initWithfirstName:@"" lastName:@"" dci:@"0000000000"];
}

//4/29 --- to convert image to thumbnail
-(void)setThumbnailFromImage:(UIImage *)image
{
    CGSize origImageSize = image.size;
    
    //the rectangle of the thumbnail
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    //figure out scaling ratio, so same aspect from original to thumb
    float ratio = MAX(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    
    //create transparent bitmap context with a scaling factor
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    //create a path that is a rounded rectangle
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    //make all subsequent drawing clip to this rounded rectangle
    [path addClip];
    
    //center the image in the thumbnail rect
    CGRect projectRect;
    
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) /2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) /2.0;
    
    //Draw image on rect
    [image drawInRect:projectRect];
    
    //get image from image context, keep as thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    //Cleanup image context resources
    UIGraphicsEndImageContext();
}



@end

//
//  SortViewController.m
//  MTGApplication
//
//  Created by Pablo on 5/2/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "SortViewController.h"
#import "PlayerStore.h"
@interface SortViewController ()

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//Get the tag of the button pressed and set the sorting mode
- (IBAction)clickButton:(UIButton *)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 1:
            [PlayerStore sharedStore].sortingMode = @"firstA";
            break;
        case 2:
            [PlayerStore sharedStore].sortingMode = @"firstD";
            break;
        case 3:
            [PlayerStore sharedStore].sortingMode = @"lastA";
            break;
        case 4:
            [PlayerStore sharedStore].sortingMode = @"lastD";
            break;
        case 5:
            [PlayerStore sharedStore].sortingMode = @"dciA";
            break;
        case 6:
            [PlayerStore sharedStore].sortingMode = @"dciD";
            break;
        case 7:
            [PlayerStore sharedStore].sortingMode = @"pointsA";
            break;
        case 8:
           [ PlayerStore sharedStore].sortingMode = @"pointsD";
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

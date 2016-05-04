//
//  PodDetailViewController.m
//  MTGApplication
//
//  Created by Whitney Walters on 5/3/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "PodDetailViewController.h"

@interface PodDetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UILabel *p1;
@property (weak, nonatomic) IBOutlet UITextField *p1Points;
@property (weak, nonatomic) IBOutlet UILabel *p2;
@property (weak, nonatomic) IBOutlet UITextField *p2Points;
@property (weak, nonatomic) IBOutlet UILabel *p3;
@property (weak, nonatomic) IBOutlet UITextField *p3Points;
@property (weak, nonatomic) IBOutlet UILabel *p4;
@property (weak, nonatomic) IBOutlet UITextField *p4Points;
- (IBAction)backClick:(id)sender;

@end

@implementation PodDetailViewController
@synthesize p1,p1Points,p2,p2Points,p3,p3Points,p4,p4Points,player1,player2,player3,player4;

//Load the view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set the four player varaibles and their text
    p1.text = [NSString stringWithFormat:@"%@ %@", player1.firstName,player1.lastName];
    p1Points.text = [player1.points  stringValue];
    
    p2.text = [NSString stringWithFormat:@"%@ %@", player2.firstName,player2.lastName];
    p2Points.text = [player2.points  stringValue];
    
    p3.text = [NSString stringWithFormat:@"%@ %@", player3.firstName,player3.lastName];
    p3Points.text = [player3.points  stringValue];
    
    p4.text = [NSString stringWithFormat:@"%@ %@", player4.firstName,player4.lastName];
    p4Points.text = [player4.points  stringValue];
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


//return to the previous view controller
- (IBAction)backClick:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
@end

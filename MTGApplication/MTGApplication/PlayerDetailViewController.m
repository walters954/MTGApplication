//
//  PlayerDetailViewController.m
//  MTGApplication
//
//  Created by Pablo on 4/24/16.
//  Copyright © 2016 Team B. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "Player.h"
#import "PlayerStore.h"
#import "ImageStore.h"

@interface PlayerDetailViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>

@end

@implementation PlayerDetailViewController
@synthesize playerDataObject;
//Override the setter so that it sets the title as well as the player object 
-(void)setPlayer:(Player *)player{
    _player = player;
    self.navigationItem.title = _player.dci;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem" userInfo:nil];
    return nil;
}
- (instancetype)initForNewPlayer:(BOOL)isNew{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        if(isNew){
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;

        }
        else{
        UIBarButtonItem* updateItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(update:)];
        self.navigationItem.rightBarButtonItem = updateItem;
        }
    }
    return self;
}
//When the view appears load the data into the nib
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Player* player = self.player;
    self.firstNameTextField.text = player.firstName;
    self.lastNameTextField.text = player.lastName;
    self.dciTextField.text = player.dci;
    self.pointsTextField.text = [player.points stringValue];
    
    //Allow View to get the imageKey
    //NSString *imageKey = self.player.imageKey;
    
    //get the image for its key from image store
    //UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
    
    //use that image to put on the screen in image view
    //5/1
    self.profileImage.image = player.thumbnail;
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
//Here is where we do the saving. As the detail closes commit any changes
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.dciTextField.delegate = self;
    self.pointsTextField.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Update to coredata
- (IBAction)update:(id)sender{
    NSManagedObjectContext *context = [self managedObjectContext];
    //Pass everything
    [playerDataObject setValue:self.firstNameTextField.text forKey:@"firstName"];
    [playerDataObject setValue:self.lastNameTextField.text forKey:@"lastName"];
    [playerDataObject setValue:self.dciTextField.text forKey:@"dci"];
    NSNumber * test = [NSNumber numberWithDouble:self.pointsTextField.text.doubleValue];
    [playerDataObject setValue:test forKey:@"points"];
    UIImage* image = self.profileImage.image;
    NSData *imageData = UIImagePNGRepresentation(image);
    [playerDataObject setValue:imageData forKey:@"picture"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [PlayerStore sharedStore].isSorted = false;
    [[PlayerStore sharedStore]clearStore];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
    
}
//Action for saving new player information
- (IBAction)save:(id)sender{
    NSArray* test = [[PlayerStore sharedStore]allPlayers];
    //Do validation
    
    for(int i =0; i < test.count; i++)
    {
        Player *player = test[i];
        if([player.dci isEqualToString:self.dciTextField.text]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"DCI already Exists"
                                  message:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"OK", nil];
            [alert show];
            return;
        }
    }
        
    
    if(self.firstNameTextField.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"First name must be longer than 0"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
    else if(self.lastNameTextField.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Last name must be longer than 0"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else if(self.dciTextField.text.length == 0||[self.dciTextField.text isEqualToString:@"0000000000"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"DCI must be longer than 0"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else if(self.dciTextField.text.length >= 11){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"DCI must be equal or less than 10 characters"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:context];
    [newDevice setValue:self.firstNameTextField.text forKey:@"firstName"];
    [newDevice setValue:self.lastNameTextField.text forKey:@"lastName"];
    [newDevice setValue:self.dciTextField.text forKey:@"dci"];
    NSString * tester = self.pointsTextField.text;
    NSNumber * test = [NSNumber numberWithDouble:self.pointsTextField.text.doubleValue];
    [newDevice setValue:test forKey:@"points"];
    
    UIImage* image = self.player.thumbnail;
    NSData *imageData = UIImagePNGRepresentation(image);
    [newDevice setValue:imageData forKey:@"picture"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
    }
}
-(IBAction)cancel:(id)sender{
    [[PlayerStore sharedStore]removePlayer:self.player];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)clickSave:(id)sender {
//}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //If camera avaiable, take pic ELSE photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    //image picker on screen
        imagePicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //4/29 --
    [self.player setThumbnail:image];
        
    //store the image in ImageStore for this key
    [[ImageStore sharedStore]setImage:image forKey:self.player.imageKey];
    
    //put that image onto the screen in image view
    self.profileImage.image = image;
    
    //take image picker off screen with dismis methoe
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//Keyboard 
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
//Keyboard disappear, when tapping away from keyboard
- (IBAction)backgroundTapped:(id)sender {
    
    [self.view endEditing:YES];
}


@end

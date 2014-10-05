//
//  MakeViewController.m
//  Magnet
//
//  Created by Valentin Perez on 10/4/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "MakeViewController.h"
#import <Parse/Parse.h>
#import "UserManager.h"

@interface MakeViewController ()
{
    UserManager *sharedUserManager;
    PFUser *currentUser;
}
@end

@implementation MakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *className = [[NSUserDefaults standardUserDefaults] objectForKey:@"classSelected"];
    sharedUserManager = [UserManager sharedUserManager];
    NSLog(@"className %@", className);
    currentUser = [PFUser currentUser];
    _classTitleLabel2.text = className;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnScreen)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    
}
- (void) tappedOnScreen
{
    [self.view endEditing:YES];
    
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:(BOOL) animated];
    
    NSLog(@"make view loaded");
    UIColor *magnetColor = [UIColor colorWithRed:43.0f/255 green:43.0f/255 blue:43.0f/255 alpha:.1];
    self.view.backgroundColor = magnetColor;
    
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

- (IBAction)tappedCreate:(id)sender
{
    NSLog(@"tapping");
    PFObject *newStudyEvent = [PFObject objectWithClassName:@"StudyMagnet"];
    
    if (_whereTextField.text)
        newStudyEvent[@"placeName"] = _whereTextField.text;
    
    
    newStudyEvent[@"location"] = currentUser[@"location"];//[PFGeoPoint geoPointWithLatitude:sharedUserManager.userLat longitude:sharedUserManager.userLang];
    
    if (_noteTextField.text)
        newStudyEvent[@"note"] = _noteTextField.text;
    
    [newStudyEvent saveInBackground];
   // newStudyEvent[@"note"] =
   // newStudyEvent[@"date"] =
   // NSLog(@"PFStudyEvent : %@", newStudyEvent);
    //[testObject saveInBackground];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

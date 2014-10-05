//
//  SignUpViewController.m
//  Magnet
//
//  Created by Valentin Perez on 10/4/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "NavigationViewController.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface SignUpViewController ()
{
    AppDelegate *app;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = [[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
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
- (void) showStartingNextView
{
    
    
}
-(void) showNextView
{
    NavigationViewController *navVC = [self.storyboard instantiateViewControllerWithIdentifier:@"rootController"];
    app.window.rootViewController = navVC;
    
}
- (IBAction)tappedLogInWithFacebook:(id)sender
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
        [hud hide:YES];
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                if ( error.code == 2)
                {
                    [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"You must allow access to your Facebook account. You can manage what can access your Facebook in the Settings app." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                    
                }
                else
                    [[[UIAlertView alloc] initWithTitle:@"Oops" message:error.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                
                //[self showBubbles];
                
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self showStartingNextView];
            
            //[self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
            [self showNextView];
            
        }
    }];

}
@end

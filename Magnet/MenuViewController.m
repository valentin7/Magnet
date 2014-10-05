//
//  MenuViewController.m
//  Magnet
//
//  Created by Valentin Perez on 10/4/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "MenuViewController.h"
#import "ClassTableViewCell.h"
#import "UserManager.h"
#import <Parse/Parse.h>

@interface MenuViewController ()
{
    NSArray *allClasses;
    UserManager *sharedUserManager;
    NSUserDefaults *defaults;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    sharedUserManager = [UserManager sharedUserManager];
    defaults = [NSUserDefaults standardUserDefaults];
    
   // [self getClasses];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self getClasses];
    
}
- (void) getClasses
{
    PFQuery *query = [PFQuery queryWithClassName:@"Class"];
     [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         NSLog(@"ALL CLASSES: %@", objects);
         allClasses = objects;
         [self.tableView reloadData];
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma mark TableView Delegate & DataSource Methods
- (NSInteger) numberOfSectionsInTableView:( UITableView *) tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if (facebookGroups.count ==0)
    //   return 0;
    return allClasses.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [defaults setObject:allClasses[indexPath.row][@"name"] forKey:@"classSelected"];
    [defaults synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *) tableView:( UITableView *) tableView cellForRowAtIndexPath:( NSIndexPath *) indexPath
{
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    ClassTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"classCell" forIndexPath:indexPath];
    /*NSString *classCode = [allClasses[indexPath.row] substringToIndex: allClasses[indexPath.row ]
                    NSScanner *scanner = [NSScanner scannerWithString:string];
                           [scanner scanUpToString:match intoString:&preTel];
                           
                           [scanner scanString:match intoString:nil];
                           postTel = [string substringFromIndex:scanner.scanLocation];
                           
                           NSLog(@"preTel: %@", preTel);
                           NSLog(@"postTel: %@", postTel);*/
    /*NSArray *substrings = [allClasses[indexPath.row] componentsSeparatedByString:@" "];

    
    for (int i = 1; i<substrings.count; i++)
    {
        second = [second stringByAppendingString: [NSString stringWithFormat:@" %@", substrings[i]]];
    }
    */
    NSString *first = @"";
    NSString *second = @"";
    NSString *full = (NSString *) allClasses[indexPath.row][@"name"];
    for (int i = 0; i<(int)full.length; i++)
    {
        if ([full characterAtIndex:i] == ' ')
        {
            NSRange ran = NSMakeRange(0, i);
            first = [full substringWithRange:ran];
            second = [full substringFromIndex:i];
            break;
        }
    }
    cell.titleLabel.text = first;
    cell.titleLabel2.text = second;
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.3];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

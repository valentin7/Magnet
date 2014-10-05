//
//  MakeViewController.h
//  Magnet
//
//  Created by Valentin Perez on 10/4/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *whereTextField;
@property (strong, nonatomic) IBOutlet UITextField *noteTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *classTitleLabel1;
@property (strong, nonatomic) IBOutlet UILabel *classTitleLabel2;
- (IBAction)tappedCreate:(id)sender;

@end

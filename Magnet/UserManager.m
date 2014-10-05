//
//  UserManager.m
//  endLine
//
//  Created by Valentin Perez on 6/24/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

@synthesize  classSelected, emailSent, userLang, userLat;

#pragma mark Singleton Methods

+ (id)sharedUserManager
{
    static UserManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    // Ensure it is created only once.
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id) init
{
    if (self = [super init])
    {
        classSelected = [[NSString alloc] init];
        emailSent = [[NSString alloc] init];
        
    }
    return self;
}

- (void) showErrorAlert
{
    
    /*
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error processing request."
                                                        message: @"Make sure you have internet connection and try later."
                                                       delegate: self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];*/
    
}


@end
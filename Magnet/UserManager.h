//
//  UserManager.h
//  endLine
//
//  Created by Valentin Perez on 6/24/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * This class is a singleton representing the user and his information and meant to
 * allow easy access to them.
 */

@interface UserManager : NSObject
{
    //NSMutableDictionary *allShoppingCarts;
    NSString *classSelected;
    NSString *emailSent;

    int placeSelectedIndex;
    float userLat;
    float userLang;
    
    BOOL loggedIn;
}


@property (retain, nonatomic) NSString *classSelected;

@property (retain, nonatomic) NSString *emailSent;

@property (readwrite, nonatomic) float userLat;
@property (readwrite, nonatomic) float userLang;



- (void) showErrorAlert;
+ (id)sharedUserManager;

@end
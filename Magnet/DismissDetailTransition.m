//
//  DismissDetailTransition.m
//  NMH
//
//  Created by Valentin Perez on 4/21/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "DismissDetailTransition.h"

@implementation DismissDetailTransition


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [UIView animateWithDuration:.38 animations:^{
        detail.view.alpha = 0;
    } completion:^(BOOL finished){
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
        NSLog(@"FINISHED S");
        
        
    }];
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .38;
    
}

@end

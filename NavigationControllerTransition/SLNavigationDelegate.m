//
//  SLNavigationDelegate.m
//  NavigationControllerTransition
//
//  Created by songlin on 2016/12/31.
//  Copyright © 2016年 songlin. All rights reserved.
//

#import "SLNavigationDelegate.h"
#import "SlideAnimationController.h"

@implementation SLNavigationDelegate

-(instancetype)init {
    if (self = [super init]) {
        _interactive = false;
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSUInteger transitionType = operation;
    SlideAnimationController *slide = [[SlideAnimationController alloc]init];
    slide.transitionType = transitionType;
    return slide;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _interactive ? _interactionController : nil;
}

@end

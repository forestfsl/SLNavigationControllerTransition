//
//  SlideAnimationController.m
//  NavigationControllerTransition
//
//  Created by songlin on 2016/12/31.
//  Copyright © 2016年 songlin. All rights reserved.
//

#import "SlideAnimationController.h"

@implementation SlideAnimationController


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    CGFloat translation = containView.frame.size.width;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    switch (_transitionType) {
        case TransitionTypePush:
        case TransitionTypeRight:
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            break;
        case TransitionTypePop:
        case TransitionTypeLeft:
            toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            break;
        case TransitionTypePresentation:
            translation = containView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, translation);
            fromViewTransform = CGAffineTransformMakeTranslation(0, 0);
            break;
        case TransitionTypeDismisssal:
            translation = containView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(0, translation);
            break;
        default:
            break;
    }
    switch (_transitionType) {
        case TransitionTypePresentation:
            [containView addSubview:toView];
            break;
        case TransitionTypeDismisssal:
            break;
        default:
            [containView addSubview:toView];
            break;
    }
    
    toView.transform = toViewTransform;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
       /* 转场的结果有两种：完成或取消。非交互转场的结果只有完成一种情况，不过交互式转场需要考虑取消的情况。如何结束取决于转场的进度，通过[transitionContext transitionWasCancelled]方法来获取转场的结果，然后使用completeTransition:来通知系统转场过程结束，这个方法会检查动画控制器是否实现了animationEnded:方法，如果有，则调用该方法*/
        CGFloat isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}


@end

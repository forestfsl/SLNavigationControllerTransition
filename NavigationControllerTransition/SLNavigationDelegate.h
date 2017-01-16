//
//  SLNavigationDelegate.h
//  NavigationControllerTransition
//
//  Created by songlin on 2016/12/31.
//  Copyright © 2016年 songlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SLNavigationDelegate : NSObject<UINavigationControllerDelegate>

@property (nonatomic ,assign) BOOL interactive;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

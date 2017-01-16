//
//  PopViewController.m
//  NavigationControllerTransition
//
//  Created by songlin on 2016/12/31.
//  Copyright © 2016年 songlin. All rights reserved.
//

#import "PopViewController.h"
#import "SLNavigationDelegate.h"

@interface PopViewController ()

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanGesture;
@property (nonatomic, strong) SLNavigationDelegate *navigationDelegate;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"StackTop";
   
    _edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleEdgePanGesture:)];
     _edgePanGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_edgePanGesture];
}


-(void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat translationX = [gesture translationInView:self.view].x;
    CGFloat translationBase = self.view.frame.size.width / 3;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat percent = translationAbs > translationBase ? 1.0 : translationAbs / translationBase;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _navigationDelegate = self.navigationController.delegate;
            _navigationDelegate.interactive = true;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [_navigationDelegate.interactionController updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if (percent > 0.5) {
                [_navigationDelegate.interactionController finishInteractiveTransition];
            }else {
                [_navigationDelegate.interactionController cancelInteractiveTransition];
            }
            _navigationDelegate.interactive = false;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popAction:(id)sender {
    NSLog(@"self.navigationController.view:%@",self.navigationController.view);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc {
    [_edgePanGesture removeTarget:self action:@selector(handleEdgePanGesture:)];
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

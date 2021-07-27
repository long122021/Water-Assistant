//
//  RootNavigationController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import "RootNavigationController.h"
#import "RootTabBarViewController.h"
#import "AppDelegate.h"
#import "MiscUtils.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName: ThemeColor}];
    
    [self.navigationBar setTintColor:ThemeColor];
    
    RootTabBarViewController* tabBarVC = [RootTabBarViewController new];
    [self pushViewController:tabBarVC animated:NO];
}


#pragma mark - Navigation

+(void)pushViewController:(UIViewController*)vc animated:(BOOL)animated{
    UIWindow* window = [UIApplication sharedApplication].windows.firstObject;
    RootNavigationController *rootController = (RootNavigationController *) window.rootViewController;
    
    if ([rootController isKindOfClass:[RootNavigationController class]]) {
        if (rootController.viewControllers.count >= 50)
        {
            return;
        }
        
        [rootController pushViewController:vc animated:animated];
    }
}

+(void)popViewController:(BOOL)animated{
    UIWindow* window = [UIApplication sharedApplication].windows.firstObject;
    RootNavigationController *rootController = (RootNavigationController *) window.rootViewController;
    
    if ([rootController isKindOfClass:[UINavigationController class]]) {
        [rootController popViewControllerAnimated:animated];
    }
}
@end

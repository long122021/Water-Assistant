//
//  RootTabBarViewController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import "RootTabBarViewController.h"
#import "HomeViewController.h"
#import "ChatViewController.h"
#import "MeViewController.h"
#import "MiscUtils.h"

@interface RootTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    NSMutableArray* arrVC = [NSMutableArray new];
    HomeViewController* homeVC = [HomeViewController new];
    UITabBarItem* homeItem = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"tabbar_home_1"] selectedImage:[UIImage imageNamed:@"tabbar_home_2"]];
    homeVC.tabBarItem = homeItem;
    homeVC.navigationItem.title = @"Water Assistant";
    [arrVC addObject:homeVC];
    
    ChatViewController* chatVC = [ChatViewController new];
    UITabBarItem* chatItem = [[UITabBarItem alloc]initWithTitle:@"Chat" image:[UIImage imageNamed:@"tabbar_chat_1"] selectedImage:[UIImage imageNamed:@"tabbar_chat_2"]];
    chatVC.tabBarItem = chatItem;
    chatVC.navigationItem.title = chatItem.title;
    [arrVC addObject:chatVC];
    
    MeViewController* meVC = [MeViewController new];
    UITabBarItem* meItem = [[UITabBarItem alloc]initWithTitle:@"Me" image:[UIImage imageNamed:@"tabbar_me_1"] selectedImage:[UIImage imageNamed:@"tabbar_me_2"]];
    meVC.tabBarItem = meItem;
    meVC.navigationItem.title = meItem.title;
    [arrVC addObject:meVC];
//    self.tabBar.tintColor = [UIColor colorWithRed:44/255.0 green:195/255.0 blue:248/255.0 alpha:255/255.0];
    self.tabBar.tintColor = ThemeColor;
    self.viewControllers = arrVC;
    
    self.navigationItem.title = homeVC.navigationItem.title;
}

//- (void)setTabBarItemColor:(UITabBarItem*)item{
//    if(@available(iOS 13.0, *)) {
//
//        self.tabBar.tintColor = [UIColor colorWithHexString:@"#2CC3F8 "];
//        self.tabBar.unselectedItemTintColor = [UIColor colorWithHexString:@"#333333"];
//        UITabBarItem *item = [UITabBarItem appearance];
//        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
//    }
//    else{
//        UITabBarItem *item = [UITabBarItem appearance];
//        [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FF0009"],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
//    }
//}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    self.navigationItem.title = viewController.navigationItem.title;
    
    return YES;
}




//pod "XJYChart"
	

@end

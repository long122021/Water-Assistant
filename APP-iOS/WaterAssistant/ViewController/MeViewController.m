//
//  MeViewController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import "MeViewController.h"
#import "MiscUtils.h"
#import "RootNavigationController.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "ChangePswViewController.h"

@interface MeViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewNotifBg;
@property (weak, nonatomic) IBOutlet UISwitch *notifSwitch;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin1;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (nonatomic, assign)BOOL isLogin;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _viewNotifBg.layer.cornerRadius = 10;
    _viewNotifBg.layer.shadowColor = ShadowColor.CGColor;
    _viewNotifBg.layer.shadowOffset = CGSizeMake(0,0.5);
    _viewNotifBg.layer.shadowOpacity = 0.2;
    _viewNotifBg.layer.shadowRadius = 10;
    _viewNotifBg.clipsToBounds = NO;
    
    _notifSwitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
    _notifSwitch.onTintColor = ThemeColor;
    
    
}

- (void)showLoginView{
    LoginViewController* vc = [LoginViewController new];
    [self presentViewController:vc animated:YES completion:nil];
//    [RootNavigationController pushViewController:vc animated:YES];
}

- (IBAction)onIconLogin:(id)sender {
    if (_isLogin) {
        return;
    }
    [self showLoginView];
}

- (IBAction)onLogin:(id)sender {
    if (!_isLogin) {
        [self showLoginView];
        return;
    }
}

- (IBAction)onPersonalInfo:(id)sender {
    UserInfoViewController* vc = [UserInfoViewController new];
    [RootNavigationController pushViewController:vc animated:YES];
}

- (IBAction)onChangePsw:(id)sender {
    ChangePswViewController* vc = [ChangePswViewController new];
    [RootNavigationController pushViewController:vc animated:YES];
}

@end

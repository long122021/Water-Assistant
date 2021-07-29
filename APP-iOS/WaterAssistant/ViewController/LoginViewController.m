//
//  LoginViewController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import "LoginViewController.h"
#import "MiscUtils.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lblTitle.textColor = ThemeColor;
    
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

//
//  ChatViewController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import "ChatViewController.h"
#import <WebKit/WebKit.h>

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     //初始化
    
    NSURL* url = [NSURL URLWithString:@"https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=us-south&integrationID=1dd8b2f8-997e-44a5-9f40-c9b3b82c4e3b&serviceInstanceID=8f7c598d-d55e-45cf-8ad1-1cae7f2f8184"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
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

//
//  HomeDetailView.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/9.
//

#import "HomeDetailView.h"
#import "DetailViewController.h"
#import "RootNavigationController.h"
#import "MiscUtils.h"

@interface HomeDetailView ()

@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnHide;

@property (nonatomic, strong)WaterMachine* data;
@end

@implementation HomeDetailView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _viewBg.layer.cornerRadius = 10;
    _btnDetail.layer.cornerRadius = 10;
    _btnHide.layer.cornerRadius = 10;
    _lblScore.layer.cornerRadius = 12;
    _lblScore.textColor = WaterColor_3;
    _lblScore.layer.borderColor = _lblScore.textColor.CGColor;
    _lblScore.layer.borderWidth = 2;
    
//    UIColor* shadowColor = [UIColor grayColor];
    //加阴影
//    _btnHide.layer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
//    _btnHide.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    _btnHide.layer.shadowOpacity = 0.12;//阴影透明度，默认0
//    _btnHide.layer.shadowRadius = 4;//阴影半径，默认3
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)]];
}

- (void)show{
    UIWindow* window = [UIApplication sharedApplication].windows.firstObject;
    self.frame = CGRectMake(0, 0, window.layer.frame.size.width, window.layer.frame.size.height);
    [window addSubview:self];
    
    self.alpha = 0;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.alpha = 1;
    } completion:^(BOOL finished) {
        weakSelf.alpha = 1;
    }];
}

- (void)onTap{
    if (self.delegate) {
        [self.delegate didDetailHide:self];
    }
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}
- (IBAction)onHide:(id)sender {
    [self onTap];
}

- (IBAction)onDetail:(id)sender {
    DetailViewController* vc = [DetailViewController new];
    vc.waterData = _data;
    [RootNavigationController pushViewController:vc animated:YES];
    [self onTap];
}

- (void)loadData:(WaterMachine *)data{
    _data = data;
    _lblScore.text = [NSString stringWithFormat:@"%.1f", data.score];
    _lblDesc.text = data.desc;
}
@end

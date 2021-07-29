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
@property (weak, nonatomic) IBOutlet UIView *viewScoreBg;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnHide;
@property (weak, nonatomic) IBOutlet UILabel *lblWaterDepth;
@property (weak, nonatomic) IBOutlet UILabel *lblWaterName;

@property (nonatomic, strong)WaterMachine* data;
@end

@implementation HomeDetailView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _viewBg.layer.cornerRadius = 10;
    _btnDetail.layer.cornerRadius = 10;
    _btnHide.layer.cornerRadius = 10;
    
    _btnHide.layer.shadowColor = ShadowColor.CGColor;
    _btnHide.layer.shadowOffset = CGSizeMake(0,0.5);
    _btnHide.layer.shadowOpacity = 0.12;
    _btnHide.layer.shadowRadius = 10;
    _btnHide.clipsToBounds = NO;
    
    
    _viewBg.layer.shadowColor = ShadowColor.CGColor;
    _viewBg.layer.shadowOffset = CGSizeMake(0,0.5);
    _viewBg.layer.shadowOpacity = 0.2;
    _viewBg.layer.shadowRadius = 10;
    _viewBg.clipsToBounds = NO;
    
    
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
    _lblWaterName.text = data.name;
    _lblScore.text = data.waterData.typeStr;
    _lblDesc.text = data.waterData.desc;
    _lblWaterDepth.text = [NSString stringWithFormat:@"%.1fm",data.waterData.depth];
    
    _lblScore.textColor = data.waterData.typeColor;
    _viewScoreBg.layer.cornerRadius = 12;
    _viewScoreBg.layer.borderColor = _lblScore.textColor.CGColor;
    _viewScoreBg.layer.borderWidth = 2;
}
@end

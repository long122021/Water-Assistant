//
//  AttributeAlertView.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/14.
//

#import "AttributeAlertView.h"
#import "MiscUtils.h"

@interface AttributeAlertView ()
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end

@implementation AttributeAlertView

+ (instancetype)create{
    AttributeAlertView* view = [[NSBundle mainBundle]loadNibNamed:@"AttributeAlertView" owner:nil options:nil].firstObject;
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _viewBg.layer.cornerRadius = 10;
    UIColor* shadowColor = UIColorHex(#787993);
    _viewBg.layer.shadowColor = shadowColor.CGColor;
    _viewBg.layer.shadowOffset = CGSizeMake(0,0.5);
    _viewBg.layer.shadowOpacity = 0.2;
    _viewBg.layer.shadowRadius = 10;
    _viewBg.clipsToBounds = NO;
    
    _tvDesc.editable = NO;
}

- (void)show:(NSString*)title desc:(NSString*)desc{
    _lblTitle.text = title;
    _tvDesc.text = desc;
    
    UIWindow* window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:self];
}

- (IBAction)onClose:(id)sender {
    [self removeFromSuperview];
}
@end

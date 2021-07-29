//
//  AttributeView.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/14.
//

#import "AttributeView.h"
#import "MiscUtils.h"
#import "AttributeAlertView.h"

@interface AttributeView ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblValue;
@property (weak, nonatomic) IBOutlet UIButton *btnDesc;

@property (nonatomic, strong)NSString* desc;
@end

@implementation AttributeView

+ (instancetype)create{
    AttributeView* view = [[NSBundle mainBundle]loadNibNamed:@"AttributeView" owner:nil options:nil].firstObject;
    
    return view;
}

- (void)loadData:(WaterAttribute*)data{
    _desc = data.desc;
    _lblTitle.text = data.name;
    float value = [data.value floatValue];
    _lblValue.text = [NSString stringWithFormat:@"%.2f%@", value, data.unit];
}

- (void)loadData:(NSString*)title valueStr:(NSString*)valueStr desc:(NSString*)desc{
    _desc = desc;
    _lblTitle.text = title;
    _lblValue.text = valueStr;
}

- (IBAction)onDesc:(id)sender {
    AttributeAlertView* alertView = [AttributeAlertView create];
    [alertView show:_lblTitle.text desc:_desc];
}

@end

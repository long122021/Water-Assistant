//
//  AttributeAlertView.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttributeAlertView : UIView
+ (instancetype)create;
- (void)show:(NSString*)title desc:(NSString*)desc;
@end

NS_ASSUME_NONNULL_END

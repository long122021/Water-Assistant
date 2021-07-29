//
//  AttributeView.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/14.
//

#import <UIKit/UIKit.h>
#import "WaterData.h"
NS_ASSUME_NONNULL_BEGIN

@interface AttributeView : UIView
+(instancetype)create;
- (void)loadData:(NSString*)title valueStr:(NSString*)valueStr desc:(NSString*)desc;
- (void)loadData:(WaterAttribute*)data;
@end

NS_ASSUME_NONNULL_END

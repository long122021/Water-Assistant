//
//  RootNavigationController.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootNavigationController : UINavigationController

+(void)pushViewController:(UIViewController*)vc animated:(BOOL)animated;
+(void)popViewController:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

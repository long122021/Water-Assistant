//
//  DetailViewController.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import <UIKit/UIKit.h>
#import "WaterMachine.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic, strong)WaterMachine* waterData;

@end

NS_ASSUME_NONNULL_END

//
//  HomeDetailView.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/9.
//

#import <UIKit/UIKit.h>
#import "WaterMachine.h"
NS_ASSUME_NONNULL_BEGIN
@class HomeDetailView;
@protocol HomeDetailViewDelegate<NSObject>
@optional
- (void) didDetailHide:(HomeDetailView*)view;
@end

@interface HomeDetailView : UIView
@property (nonatomic, weak)id<HomeDetailViewDelegate> delegate;

- (void)loadData:(WaterMachine*)data;
- (void)show;
@end

NS_ASSUME_NONNULL_END

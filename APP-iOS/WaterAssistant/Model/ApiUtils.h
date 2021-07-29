//
//  ApiUtils.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
NS_ASSUME_NONNULL_BEGIN

#define HZTNET [ApiUtils sharedInstance]

typedef void(^ApiBlock)(NSInteger code, NSError * _Nullable err);

@interface ApiUtils : NSObject
+ (instancetype)sharedInstance;
- (void)sendRequest:(BaseRequest *)request result:(ApiBlock)result;
@end

NS_ASSUME_NONNULL_END

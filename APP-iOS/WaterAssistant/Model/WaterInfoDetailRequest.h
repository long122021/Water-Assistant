//
//  WaterInfoDetailRequest.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import "WaterPrediction.h"
NS_ASSUME_NONNULL_BEGIN

@interface WaterInfoDetailRequest : BaseRequest
@property (nonatomic, strong)NSString* waterId;
@property (nonatomic, strong)WaterPrediction* waterP;
@end

NS_ASSUME_NONNULL_END

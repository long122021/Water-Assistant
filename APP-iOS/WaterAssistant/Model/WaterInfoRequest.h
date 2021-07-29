//
//  WaterInfoRequest.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import "WaterData.h"
NS_ASSUME_NONNULL_BEGIN

@interface WaterInfoRequest : BaseRequest
@property (nonatomic, strong)NSString* machineId;
@property (nonatomic, strong)WaterData* waterData;
@end

NS_ASSUME_NONNULL_END

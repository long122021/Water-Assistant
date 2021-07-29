//
//  WaterMachine.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/9.
//

#import <Foundation/Foundation.h>
#import "WaterData.h"

NS_ASSUME_NONNULL_BEGIN

@interface WaterMachine : NSObject
//id
@property (nonatomic, strong)NSString* watermachineId;
//longitude
@property (nonatomic, assign)double longitude;
//latitude
@property (nonatomic, assign)double latitude;
//name
@property (nonatomic, strong)NSString* name;
//Water Data
@property (nonatomic, strong)WaterData* waterData;
@end

NS_ASSUME_NONNULL_END

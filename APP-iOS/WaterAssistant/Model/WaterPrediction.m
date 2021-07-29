//
//  WaterPrediction.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/20.
//

#import "WaterPrediction.h"

@implementation WaterPredictionData

@end

@implementation WaterPrediction
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pData" : WaterPredictionData.class,
             };
}
@end

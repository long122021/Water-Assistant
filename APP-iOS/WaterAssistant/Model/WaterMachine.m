//
//  WaterMachine.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/9.
//

#import "WaterMachine.h"

@implementation WaterMachine

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"waterData" : WaterData.class,
             };
}

@end


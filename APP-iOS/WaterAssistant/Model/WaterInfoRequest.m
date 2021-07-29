//
//  WaterInfoRequest.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import "WaterInfoRequest.h"

@implementation WaterInfoRequest

- (NSString*)urlBackEnd{
    return @"waterInfo";
}

- (NSString*)method{
    return GET;
}

- (NSDictionary*)parameters{
    NSMutableDictionary* dic = [NSMutableDictionary new];
    [dic setValue:_machineId forKey:@"watermachineId"];
    return dic;
}

- (void)extralResponseHandle:(id)response{
    _waterData = [WaterData modelWithDictionary:response];
}

@end

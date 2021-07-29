//
//  WaterInfoDetailRequest.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import "WaterInfoDetailRequest.h"

@implementation WaterInfoDetailRequest

- (NSString*)urlBackEnd{
    return @"waterInfoDetail";
}

- (NSString*)method{
    return GET;
}

- (NSDictionary*)parameters{
    NSMutableDictionary* dic = [NSMutableDictionary new];
    [dic setValue:_waterId forKey:@"waterId"];
    return dic;
}

- (void)extralResponseHandle:(id)response{
    if (response) {
        _waterP = [WaterPrediction modelWithJSON:response];
//        _waterData.waterAttributes = [NSArray modelArrayWithClass:[WaterAttribute class] json:response];
    }
}

@end

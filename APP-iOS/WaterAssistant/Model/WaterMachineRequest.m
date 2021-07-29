//
//  WaterMachineRequest.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import "WaterMachineRequest.h"
#import <YYKit/YYKit.h>
@implementation WaterMachineRequest

- (NSString*)urlBackEnd{
    return @"waterMachine";
}

- (NSString*)method{
    return GET;
}

- (void)extralResponseHandle:(id)response{
    if (response) {
        _arrMachine = [NSArray modelArrayWithClass:[WaterMachine class] json:response];
    }
}

@end

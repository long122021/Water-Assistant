//
//  WaterMachineRequest.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import "WaterMachine.h"
NS_ASSUME_NONNULL_BEGIN

@interface WaterMachineRequest : BaseRequest
@property (nonatomic, strong)NSArray<WaterMachine*>* arrMachine;
@end

NS_ASSUME_NONNULL_END

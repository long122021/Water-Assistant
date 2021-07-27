//
//  WaterMachine.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterMachine : NSObject
//id
@property (nonatomic, strong)NSString* machineId;
//longitude
@property (nonatomic, assign)double longitude;
//latitude
@property (nonatomic, assign)double latitude;
//name
@property (nonatomic, strong)NSString* name;
//score
@property (nonatomic, assign)float score;
//type
@property (nonatomic, assign)int type;
//desc
@property (nonatomic, strong)NSString* desc;

@end

NS_ASSUME_NONNULL_END

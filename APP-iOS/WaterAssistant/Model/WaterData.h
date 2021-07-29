//
//  WaterData.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WaterPrediction.h"

NS_ASSUME_NONNULL_BEGIN
@interface WaterAttribute : NSObject
//name
@property (nonatomic, strong)NSString* name;
//score
@property (nonatomic, strong)NSString* value;
//unit
@property (nonatomic, strong)NSString* unit;
//desc
@property (nonatomic, strong)NSString* desc;
@end


@interface WaterData : NSObject
@property (nonatomic, strong)NSString* _id;

@property (nonatomic, strong)NSString* waterId;
//depth
@property (nonatomic, assign)float depth;
//type
@property (nonatomic, assign)int type;
//type string
@property (nonatomic, strong)NSString* typeStr;
//type color
@property (nonatomic, strong)UIColor* typeColor;
//desc
@property (nonatomic, strong)NSString* desc;
//attributes
@property (nonatomic, strong)NSArray<WaterAttribute*>* waterAttributes;
//Prediction
@property (nonatomic, strong)WaterPrediction* waterP;
@end

NS_ASSUME_NONNULL_END

//
//  WaterPrediction.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/20.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

NS_ASSUME_NONNULL_BEGIN
@interface WaterPredictionData : NSObject
@property (nonatomic, strong)NSString* days;
@property (nonatomic, assign)int type;
@property (nonatomic, assign)CGFloat depth;
@end

@interface WaterPrediction : NSObject
@property (nonatomic, strong)NSString* waterId;
@property (nonatomic, strong)NSString* desc;
@property (nonatomic, strong)NSArray<WaterPredictionData*>* pData;
@end

NS_ASSUME_NONNULL_END

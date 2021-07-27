//
//  CustomAnnotation.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/9.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "WaterMachine.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

@property (nonatomic, strong)WaterMachine* data;
@property (nonatomic, strong)NSString* imageNor;
@property (nonatomic, strong)NSString* imageSel;
@end

NS_ASSUME_NONNULL_END

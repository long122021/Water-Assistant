//
//  CustomAnnotation.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/9.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

//ann.imageNor = [NSString stringWithFormat:@"water_sel_%d",ann.data.type];
//ann.imageSel = [NSString stringWithFormat:@"water_sel_%d",ann.data.type];

- (NSString*)imageSel{
    if (!_imageSel || _imageSel.length == 0) {
        _imageSel = [NSString stringWithFormat:@"water_sel_%d",_data.waterData.type];
    }
    return _imageSel;
}

- (NSString*)imageNor{
    if (!_imageNor || _imageNor.length == 0) {
        _imageNor = [NSString stringWithFormat:@"water_nor_%d",_data.waterData.type];
    }
    return _imageNor;
}

@end

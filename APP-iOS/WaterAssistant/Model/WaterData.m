//
//  WaterData.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/16.
//

#import "WaterData.h"
#import "MiscUtils.h"

@implementation WaterAttribute

- (void)setName:(NSString *)name{
    _name = name;
    if ([_name isEqualToString:@"Temperature"]) {
        _unit = @"℃";
        _desc = @"Temperature of water is one of its most basic properties, and many other parameters depend on temperature for accuracy.";
    }else if ([_name isEqualToString:@"PH"]) {
        _unit = @"";
        _desc = @"PH is an important indicator of water quality. It not only directly affects the physiological activities of fish, but also indirectly affects fish by changing other physical, chemical and biological factors in the water environment. The PH value can very intuitively reflect the changes in water quality, such as the vitality of algae, the presence of carbon dioxide, etc., and it can be inferred whether it is within the normal range through the size of the PH value and the daily change of the pH value.";
    }else if ([_name isEqualToString:@"DissolvedOxygen"]) {
        _unit = @"mg/L";
        _desc = @"The molecular oxygen dissolved in water is called dissolved oxygen, usually recorded as DO, expressed in milligrams of oxygen per liter of water. The amount of dissolved oxygen in the water is an indicator to measure the self-purification capacity of the water body.";
    }else if ([_name isEqualToString:@"Conductivity"]) {
        _unit = @"μS/cm";
        _desc = @"Conductivity data can determine concentration of solutions, detect contaminants and determine the purity of water.";
    }else if ([_name isEqualToString:@"Turbidity"]) {
        _unit = @"NTU";
        _desc = @"Turbidity is the measurement of water clarity. High turbidity affects the type of vegetation that grows in water. Turbid water can lend information in regards to the health or well-being of the water body itself.";
    }else if ([_name isEqualToString:@"Permanganate"]) {
        _unit = @"mg/L";
        _desc = @"The permanganate index is a conventional measure of the contamination by organic and oxidizable inorganic matter in a water sample. It is primarily intended for judging the quality of potable water and raw waters, such as well and surface waters. ";
    }else if ([_name isEqualToString:@"Ammonia"]) {
        _unit = @"mg/L";
        _desc = @"Ammonia is a form of nitrogen which aquatic plants can absorb and incorporate into proteins, amino acids, and other molecules. High concentrations of ammonium can enhance the growth of algae and aquatic plants. Bacteria can also convert high ammonium to nitrate (NO3-) in the process of nitrification, which lowers dissolved oxygen.";
    }else if ([_name isEqualToString:@"Phosphorus"]) {
        _unit = @"mg/L";
        _desc = @"Phosphorus is vital within our freshwater ecosystems because it is the limiting nutrient for algae. Eutrophication, or excess nutrients within a body of water, can be harmful due to the potential for an explosion of plant life. ";
    }else if ([_name isEqualToString:@"Nitrogen"]) {
        _unit = @"mg/L";
        _desc = @"Nitrogen-containing compounds act as nutrients in streams, rivers, and reservoirs. The major impact of nitrates/nitrites on fresh water bodies is that of enrichment or fertilization called eutrophication. Nitrates stimulate the growth of algae and other plankton which provide food for higher organisms (invertebrates and fish); however an excess of nitrogen can cause over-production of plankton and as they die and decompose they use up the oxygen which causes other oxygen-dependent organism to die.";
    }
}

@end

@implementation WaterData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"waterAttributes" : WaterAttribute.class,
             };
}

- (NSString*)waterId{
    _waterId = __id;
    return _waterId;
}
//Ⅰ、Ⅱ、Ⅲ、Ⅳ、Ⅴ

- (void)setType:(int)type{
    _type = type;
    
    switch (_type) {
        case 1:
            _typeStr = @"Level Ⅰ";//@"Best";
            _typeColor = WaterColor_1;
            break;
        case 2:
            _typeStr = @"Level Ⅱ";//@"Best";
            _typeColor = WaterColor_2;
            break;
        case 3:
            _typeStr = @"Level Ⅲ";//@"Normal";
            _typeColor = WaterColor_3;
            break;
        case 4:
            _typeStr = @"Level Ⅳ";//@"Normal";
            _typeColor = WaterColor_4;
            break;
        case 5:
            _typeStr = @"Level Ⅴ";//@"Farming";
            _typeColor = WaterColor_5;
            break;
        case 6:
            _typeStr = @"Inferior Ⅴ";//@"Bad";
            _typeColor = WaterColor_6;
            break;
            
        default:
            _typeStr = @"NoData";
            _typeColor = WaterColor_6;
            break;
    }
    
    
}
@end

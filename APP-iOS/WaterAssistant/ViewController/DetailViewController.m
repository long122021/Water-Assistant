//
//  DetailViewController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import "DetailViewController.h"
#import <AAChartKit.h>
#import "MiscUtils.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewChartBg;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblIndicators;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommendTitle;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Detail Information";
    
    _lblLevel.textColor = ThemeColor;
    _lblIndicators.textColor = ThemeColor;
    _lblRecommendTitle.textColor = ThemeColor;
    
    [self drawChart];
}


- (void)drawChart{
    
    AAChartModel *aaChartModel1= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeSpline)//设置图表的类型(这里以设置的为折线面积图为例)
    .titleSet(@"Water quality prediction")//设置图表标题
    .subtitleSet(@"")//设置图表副标题
    .categoriesSet(@[@"7-11",@"7-12",@"7-13",@"7-14", @"7-15",@"7-16",@"7-17",@"7-18",@"7-19",@"7-20",@"7-21",@"7-22",@"7-23",@"7-24",@"7-25"])//图表横轴的内容
    .yAxisTitleSet(@"Score")//设置图表 y 轴的单位
    .markerRadiusSet(@3.0)
    .markerSymbolStyleSet(AAChartSymbolStyleTypeInnerBlank)//marker点为空心效果
    .markerSymbolSet(AAChartSymbolTypeCircle)//marker点为圆形点○
    .seriesSet(@[
            AAObject(AASeriesElement)
            .nameSet(@"score")
            .lineWidthSet(@2.0)
            .colorSet(AARgbaColor(91, 143, 249, 1.0))
            .dataSet(@[@78.5, @74.5, @81.0, @75.0, @83.0, @80.2, @83.2, @85.0, @84.5, @85.6, @80.0, @86.4, @86.7, @86.9, @87.4]),
                     ])
    ;

    
    
    
    
//    NSDictionary *gradientColorDic1 =
//    [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToBottom
//                               startColorString:AARgbaColor(91, 143, 249, 0.5)//热情的粉红, alpha 透明度 1
//                                 endColorString:AARgbaColor(91, 143, 249, 0.1)];//热情的粉红, alpha 透明度 0.3
    
//    AAChartModel *aaChartModel = AAChartModel.new
//    .chartTypeSet(AAChartTypeAreaspline)
//    .titleSet(@"Water quality prediction")//设置图表标题
//    .categoriesSet(@[
//        @"7-11",@"7-12",@"7-13",@"7-14", @"7-15",@"7-16",@"7-17",@"7-18",@"7-19",@"7-20",@"7-21",@"7-22",@"7-23",@"7-24",@"7-25"])
//    .markerRadiusSet(@3.0)//marker点半径为8个像素
//    .markerSymbolStyleSet(AAChartSymbolStyleTypeInnerBlank)//marker点为空心效果
//    .markerSymbolSet(AAChartSymbolTypeCircle)//marker点为圆形点○
//    .yAxisLineWidthSet(@0)
//    .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@0])
//    .legendEnabledSet(false)
//    .seriesSet(@[
//        AASeriesElement.new
//        .nameSet(@"")
//        .lineWidthSet(@2.0)
//        .colorSet(AARgbaColor(91, 143, 249, 1.0))//猩红色, alpha 透明度 1
//        .fillColorSet((id)gradientColorDic1)
//        .dataSet(@[@78.5, @74.5, @81.0, @75.0, @83.0, @80.2, @83.2, @85.0, @84.5, @85.6, @80.0, @86.4, @86.7, @86.9, @87.4]),
//               ]);
    
    AAChartView* chartV = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
    [_viewChartBg addSubview:chartV];
    [chartV aa_drawChartWithChartModel:aaChartModel1];
}

@end

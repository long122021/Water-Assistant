//
//  DetailViewController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import "DetailViewController.h"
#import <AAChartKit.h>
#import "MiscUtils.h"
#import "AttributeView.h"
#import "WaterInfoDetailRequest.h"
#import "ApiUtils.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewChartBg;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIView *viewLevelBg;
@property (weak, nonatomic) IBOutlet UILabel *lblIndicators;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommendTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommend;
@property (weak, nonatomic) IBOutlet UIView *viewIndicatorsBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constIndicBgHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnExpant;
@property (weak, nonatomic) IBOutlet UIView *viewWaterChartBg;
@property (weak, nonatomic) IBOutlet UILabel *lblDepth;

@property (nonatomic, assign)CGFloat indeicMinH;
@property (nonatomic, assign)CGFloat indeicMaxH;
@property (nonatomic, assign)BOOL isExpant;
@property (nonatomic, strong)NSMutableArray* arrAttViews;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Detail Information";
    
    _lblLevel.textColor = ThemeColor;
    _lblIndicators.textColor = ThemeColor;
    _lblRecommendTitle.textColor = ThemeColor;
    
    
//    [self getTestAttribute];
    [self loadData];
    [self downloadPrediction];
}

- (void)loadData{
    _lblLevel.text = _waterData.waterData.typeStr;
    _lblLevel.textColor = _waterData.waterData.typeColor;
    _lblDepth.text = [NSString stringWithFormat:@"%.1fm",_waterData.waterData.depth];
    _lblDesc.text = _waterData.waterData.desc;
    
    _viewLevelBg.layer.cornerRadius = 13;
    _viewLevelBg.layer.borderColor = _lblLevel.textColor.CGColor;
    _viewLevelBg.layer.borderWidth = 2;
    
    CGFloat viewH = 48;
    CGFloat h = 0;
    _arrAttViews = [NSMutableArray new];
    for (int i = 0; i < _waterData.waterData.waterAttributes.count; i++) {
        AttributeView* view = [AttributeView create];
        WaterAttribute* data = _waterData.waterData.waterAttributes[i];
        view.frame = CGRectMake((i%2)*(kScreenWidth/2.0), 66+i/2*(viewH+16), kScreenWidth/2.0, viewH);
        [view loadData:data];
        [_viewIndicatorsBg addSubview:view];
        h = view.bottom;
        [_arrAttViews addObject:view];
        if (i>=2) {
            view.hidden = YES;
        }
    }
    
    h += 20;
    _indeicMaxH = h+50;
    _indeicMinH = 66+viewH+16*2+50;
    _constIndicBgHeight.constant = _indeicMinH;
    
    if (_waterData.waterData.waterP) {
        [self drawChart];
    }
}

- (void)downloadPrediction{
    WaterInfoDetailRequest* req = [WaterInfoDetailRequest new];
    req.waterId = _waterData.waterData.waterId;
    __weak typeof(self) weakSelf = self;
    [HZTNET sendRequest:req result:^(NSInteger code, NSError * _Nullable err) {
        if (!err && code == 200) {
            weakSelf.waterData.waterData.waterP = req.waterP;
            [weakSelf drawChart];
        }
    }];
}

- (void)getTestAttribute{
    NSMutableArray* arrA = [NSMutableArray new];
    NSArray* arrName = @[@"Temperature",@"PH",@"DissolvedOxygen",@"Conductivity",@"Turbidity",@"Permanganate",@"Ammonia",@"Phosphorus",@"Nitrogen"];
    NSArray* arrValue = @[@"27.2",@"9.2",@"8.24",@"313.2",@"153.2",@"5.2",@"0.32",@"0.018",@"0.80"];
    
    for (int i = 0; i < arrName.count; i++) {
        WaterAttribute* att = [WaterAttribute new];
        att.name = arrName[i];
        att.value = arrValue[i];
        
        [arrA addObject:att];
    }
    
    _waterData.waterData.waterAttributes = arrA;
    
    NSArray* arrType = @[@(6),@(6),@(6),@(5),@(6),@(5),@(5)];
    NSArray* arrDepth = @[@(11.6),@(11.8),@(11.7),@(11.5),@(11.5),@(11.6),@(11.7)];
    WaterPrediction* wp = [WaterPrediction new];
    _waterData.waterData.waterP = wp;
    wp.desc = @"The water quality has been improved from Inferior V to Level V, and it is getting better. It can be observed continuously. When the water quality is raised to Level V, it can be used for agricultural irrigation. The water depth is also maintained at a stable state and is sufficient, so don't worry.";
    NSMutableArray* arrP = [NSMutableArray new];
    for (int i =0; i < arrType.count; i++) {
        WaterPredictionData* d = [WaterPredictionData new];
        d.type = [arrType[i] intValue];
        d.depth = [arrDepth[i] floatValue];
        [arrP addObject:d];
    }
    wp.pData = arrP;
    
}

- (IBAction)onExpant:(id)sender {
    _isExpant = !_isExpant;
    _constIndicBgHeight.constant = _isExpant?_indeicMaxH : _indeicMinH;
    NSString* img = _isExpant ? @"arrow_d_up" : @"arrow_d_down";
    [_btnExpant setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    for (int i = 2; i < _arrAttViews.count; i++) {
        AttributeView* view = _arrAttViews[i];
        view.hidden = !_isExpant;
    }
}

- (NSArray*)getNextWeek{
//    theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*day ];
    NSMutableArray* arrS = [NSMutableArray new];
    NSDate* dateNow = [NSDate date];
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    for (int i = 1; i <= 7; i++) {
        NSDate* date = [dateNow initWithTimeIntervalSinceNow:oneDay*i];
        [arrS addObject:[NSString stringWithFormat:@"%zd-%zd", date.month, date.day]];
    }
    return arrS;
}

- (void)drawChart{
    
//    NSArray* arrDay = @[
//        @"7-19",@"7-20",@"7-21",@"7-22",@"7-23",@"7-24",@"7-25"];
//    NSArray* arrWQ = @[@3, @3, @4, @3, @2, @3, @2];
    
    
    _lblRecommend.text = _waterData.waterData.waterP.desc;
    NSArray* arrDay = [self getNextWeek];
    NSMutableArray* arrWQ = [NSMutableArray new];
    NSMutableArray* arrWL = [NSMutableArray new];
    
    int minQ = INT_MAX;
    float minD = CGFLOAT_MAX;
    for (WaterPredictionData* data in _waterData.waterData.waterP.pData) {
//        [arrDay addObject:data.days];
        [arrWQ addObject:@(data.type)];
        [arrWL addObject:[NSNumber numberWithString:[NSString stringWithFormat:@"%.1f", data.depth]]];
        minQ = MIN(minQ, data.type);
        minD = MIN(minD, data.depth);
    }
    
    if (minQ > 0) {
        minQ = MAX(minQ-1, 0);
    }
    if (minD > 0) {
        minD = MAX(minD-1, 0) + 0.8;
    }
    
    NSDictionary *gradientColorDic1 =
    [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToBottom
                               startColorString:AARgbaColor(9, 134, 252, 0.2)
                                 endColorString:AARgbaColor(9, 134, 252, 0.0)];
    
    AAChartModel *aaChartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeSpline)
    .titleSet(@"Water Quality Prediction")//设置图表标题
    .yAxisTitleSet(@"Water Quality Level")
    .titleStyleSet(AAStyleColorSizeWeight(AARgbaColor(9, 134, 252, 1), 16, @"bold"))
    .categoriesSet(arrDay)
    .markerRadiusSet(@3.0)//marker点半径为8个像素
    .markerSymbolStyleSet(AAChartSymbolStyleTypeInnerBlank)//marker点为空心效果
    .markerSymbolSet(AAChartSymbolTypeCircle)//marker点为圆形点○
    .yAxisLineWidthSet(@0)
    .yAxisMinSet(@(minQ))
    .yAxisReversedSet(YES)
    .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])
    .legendEnabledSet(false)
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"")
        .lineWidthSet(@2.0)
        .colorSet(AARgbaColor(9, 134, 252, 1.0))
        .fillColorSet((id)gradientColorDic1)
        .dataSet(arrWQ),
               ]);
//    .dataSet(@[@3, @3, @4, @3, @4, @3, @2, @2, @3, @4, @4, @3, @2, @2, @2]),
//           ]);
    
    AAChartView* chartV = [_viewWaterChartBg viewWithTag:101];
    if (!chartV) {
        chartV = [[AAChartView alloc]initWithFrame:CGRectMake(0, 19, kScreenWidth, 220)];
        [_viewWaterChartBg addSubview:chartV];
        chartV.tag = 101;
        [chartV aa_drawChartWithChartModel:aaChartModel];
    }else{
        [chartV aa_refreshChartWithChartModel:aaChartModel];
    }
    
    
//    NSArray* arrWL = @[@8.5, @7.8, @8.0, @8.6, @8.9, @9.2, @9.8];
    NSDictionary *gradientColorDic2 =
    [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToBottom
                               startColorString:AARgbaColor(0, 168, 226, 0.2)
                                 endColorString:AARgbaColor(0, 168, 226, 0.0)];
    
    AAChartModel *aaWaterChartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeSpline)
    .titleSet(@"Water Level Prediction")//设置图表标题
    .titleStyleSet(AAStyleColorSizeWeight(AARgbaColor(0, 168, 226, 1), 16, @"bold"))
    .yAxisTitleSet(@"Unit m")
    .categoriesSet(arrDay)
    .markerRadiusSet(@3.0)//marker点半径为8个像素
    .markerSymbolStyleSet(AAChartSymbolStyleTypeInnerBlank)//marker点为空心效果
    .markerSymbolSet(AAChartSymbolTypeCircle)//marker点为圆形点○
    .yAxisLineWidthSet(@0)
    .yAxisMinSet(@(minD))
    .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@1])
    .legendEnabledSet(false)
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"")
        .lineWidthSet(@2.0)
        .colorSet(AARgbaColor(0, 168, 226, 1.0))
        .fillColorSet((id)gradientColorDic2)
        .dataSet(arrWL),
               ]);
    
    AAChartView* wChartV = [_viewChartBg viewWithTag:101];
    if (!wChartV) {
        wChartV = [[AAChartView alloc]initWithFrame:CGRectMake(0, 19, kScreenWidth, 220)];
        [_viewChartBg addSubview:wChartV];
        wChartV.tag = 101;
        [wChartV aa_drawChartWithChartModel:aaWaterChartModel];
    }else{
        [wChartV aa_refreshChartWithChartModel:aaWaterChartModel];
    }
}

@end

//
//  HomeViewController.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/8.
//

#import "HomeViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
#import "HomeDetailView.h"
#import "MiscUtils.h"
#import "ApiUtils.h"
#import "WaterMachineRequest.h"

@interface HomeViewController ()<MKMapViewDelegate, CLLocationManagerDelegate, HomeDetailViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapWater;
@property (weak, nonatomic) IBOutlet UIButton *btnZero;

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong,nonatomic) CLGeocoder * geocoder;

@property (nonatomic, strong)HomeDetailView* viewDetail;

@property (nonatomic, strong)NSMutableArray<CustomAnnotation*>* arrAnnotation;
@property (nonatomic, strong)MKAnnotationView* selAnn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initResource];
}

- (void)initResource{
    _mapWater.showsUserLocation = YES;
    _mapWater.delegate = self;
    _mapWater.userTrackingMode = MKUserTrackingModeFollow;
    
    _btnZero.layer.cornerRadius = 10;
    _btnZero.layer.shadowColor = ShadowColor.CGColor;
    _btnZero.layer.shadowOffset = CGSizeMake(0,0.5);
    _btnZero.layer.shadowOpacity = 0.12;
    _btnZero.layer.shadowRadius = 10;
    _btnZero.clipsToBounds = NO;
    
    self.mapWater.zoomEnabled = YES;   // 是否缩放
    self.mapWater.scrollEnabled = YES; // 是否滚动
//    self.mapWater.rotateEnabled = YES; // 是否旋转
    self.mapWater.pitchEnabled = NO; // 是否显示3DVIEW
    // 是否显示指南针（iOS9.0）
    self.mapWater.showsCompass = YES;
    // 是否显示比例尺（iOS9.0）
    self.mapWater.showsScale = YES;
    // 是否显示交通（iOS9.0）
    self.mapWater.showsTraffic = YES;
    // 是否显示建筑物
    self.mapWater.showsBuildings = YES;

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
//    [self.locationManager startUpdatingLocation];
    
//    26.93261121203656
//    80.04748675748408
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(26.93261121203656, 80.04748675748408);
    // 设置地图显示的范围，
    MKCoordinateSpan span;
    // 地图显示范围越小，细节越清楚
    span.latitudeDelta = 0.7;
    span.longitudeDelta = 0.7;
    // 创建MKCoordinateRegion对象，该对象代表了地图的显示中心和显示范围。
    MKCoordinateRegion region = {center,span};
    // 设置当前地图的显示中心和显示范围
    [_mapWater setRegion:region animated:YES];
    
//    [self getTestData];
    [self loadWaterData];
}
- (IBAction)onBackToLocation:(id)sender {
    
    CLLocationCoordinate2D center = self.locationManager.location.coordinate;
    // 设置地图显示的范围，
    MKCoordinateSpan span;
    // 地图显示范围越小，细节越清楚
    span.latitudeDelta = 0.18;
    span.longitudeDelta = 0.18;
    // 创建MKCoordinateRegion对象，该对象代表了地图的显示中心和显示范围。
    MKCoordinateRegion region = {center,span};
    // 设置当前地图的显示中心和显示范围
    [_mapWater setRegion:region animated:YES];
    
}

- (void)loadWaterData{
    WaterMachineRequest* req = [WaterMachineRequest new];
    __weak typeof(self) weakSelf = self;
    [HZTNET sendRequest:req result:^(NSInteger code, NSError * _Nullable err) {
        if (!err && code == 200) {
            [weakSelf reloadAnnotation:req.arrMachine];
        }else{
            
        }
    }];
}

- (void)reloadAnnotation:(NSArray*)arrMachine{
    if (_arrAnnotation) {
        [_mapWater removeAnnotations:_arrAnnotation];
    }
    _arrAnnotation = [NSMutableArray new];
    for (WaterMachine* data in arrMachine) {
        CustomAnnotation* ann = [CustomAnnotation new];
        ann.data = data;
        ann.coordinate = CLLocationCoordinate2DMake(ann.data.latitude, ann.data.longitude);
        [_arrAnnotation addObject:ann];
        [self.mapWater addAnnotation:ann];
    }
}

- (void)getTestData{
    _arrAnnotation = [NSMutableArray new];
    /*
     117.299766,31.670208
     117.373499,31.727106
     117.229985,31.702471
     117.204617,31.87343
     117.251545,31.916166
     117.207276,31.908074
     
     26.93261121203656, 80.04748675748408          Ganga River  污染            水质级别是劣5，非常差，PH过高，水中浑浊物非常多，未经处理不能使用。
     27.032160089546878, 79.99428041169088        Ganga River    污染
     26.905655013064905, 80.08068649203202        Ganga River    污染
     27.252378962904967, 79.77931651289006        Ramganga    干净
     27.314729717370014, 79.97177053858127        Ramganga    干净
     27.405244417553956, 79.73523221636472        Daher Jheel    干净
     27.193908011820234, 79.72815901304145        Kaali Nadi        一般
     */
    NSArray* arrLatitude = @[@(26.93261121203656),@(27.032160089546878),@(26.905655013064905),@(27.252378962904967),@(27.314729717370014),@(27.405244417553956),@(27.193908011820234)];
    NSArray* arrLongitude = @[@(80.04748675748408),@(79.99428041169088),@(80.08068649203202),@(79.77931651289006 ),@(79.97177053858127),@(79.73523221636472),@(79.72815901304145)];
    NSArray* arrName = @[@"Ganga River 01",@"Ganga River 02",@"Ganga River 03",@"Khoh River",@"Ramganga River",@"Daher Jheel",@"Kaali Nadi"];
    NSArray* arrType = @[@(6),@(6),@(6),@(3),@(2),@(3),@(4)];
    
    NSMutableArray* arrData = [NSMutableArray new];
    for (int i = 0; i < arrLatitude.count; i++) {
        WaterMachine* data = [WaterMachine new];
        data = [WaterMachine new];
        data.name = arrName[i];
        data.latitude = [arrLatitude[i] doubleValue];
        data.longitude = [arrLongitude[i] doubleValue];
        data.waterData = [WaterData new];
        data.waterData.type = [arrType[i] intValue];
        data.waterData.depth = 11.5;//5 + rand()%(5 + 1) + (rand()%10) /10.0;
        data.waterData.desc = @"Mainly suitable for centralized domestic and drinking water surface water source areas, secondary protection areas, fish and shrimp overwintering grounds, migration channels, aquaculture areas and other fishery waters and swimming areas。At present, the water quality is good and can be used for irrigation and household use. ";
        
        [arrData addObject:data];
    }
    
    for (WaterMachine* data in arrData) {
        CustomAnnotation* ann = [CustomAnnotation new];
        ann.data = data;
        ann.coordinate = CLLocationCoordinate2DMake(ann.data.latitude, ann.data.longitude);
        [_arrAnnotation addObject:ann];
        [self.mapWater addAnnotation:ann];
    }
}

- (void)didDetailHide:(HomeDetailView *)view{
    CustomAnnotation* ann = (CustomAnnotation*)_selAnn.annotation;
    _selAnn.image = [UIImage imageNamed:ann.imageNor];
}

#pragma mark MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(CustomAnnotation*)annotation{
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
        MKAnnotationView* customPinView = [[MKAnnotationView alloc]
                                               initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        
        UIImage *pinImage = [UIImage imageNamed:annotation.imageNor];
        customPinView.image = pinImage;
        customPinView.userInteractionEnabled = YES;
        customPinView.enabled = YES;
        customPinView.canShowCallout = NO;
        return customPinView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    if ([view.annotation isKindOfClass:[CustomAnnotation class]]) {
        CustomAnnotation* ann = (CustomAnnotation*)view.annotation;
        view.image = [UIImage imageNamed:ann.imageSel];
        _selAnn = view;
        if (!_viewDetail) {
            _viewDetail = [[NSBundle mainBundle]loadNibNamed:@"HomeDetailView" owner:nil options:nil].firstObject;
            _viewDetail.delegate = self;
        }
        [_viewDetail loadData:ann.data];
        [_viewDetail show];
        
        for (id <MKAnnotation>annotation in self.mapWater.annotations) {
            [self.mapWater deselectAnnotation:annotation animated:YES];
        }
    }
    
    return;
}
@end

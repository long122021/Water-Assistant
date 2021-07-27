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
    [self.locationManager startUpdatingLocation];
    
    [self getTestData];
}
- (IBAction)onBackToLocation:(id)sender {
    
    CLLocationCoordinate2D center = self.locationManager.location.coordinate;
    // 设置地图显示的范围，
    MKCoordinateSpan span;
    // 地图显示范围越小，细节越清楚
    span.latitudeDelta = 0.2;
    span.longitudeDelta = 0.2;
    // 创建MKCoordinateRegion对象，该对象代表了地图的显示中心和显示范围。
    MKCoordinateRegion region = {center,span};
    // 设置当前地图的显示中心和显示范围
    [_mapWater setRegion:region animated:YES];
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
     */
    NSArray* arrLongitude = @[@(117.299766),@(117.373499),@(117.229985),@(117.204617),@(117.251545),@(117.207276)];
    NSArray* arrLatitude = @[@(31.670208),@(31.727106),@(31.702471),@(31.87343),@(31.916166),@(31.908074)];
    for (int i = 0; i < arrLatitude.count; i++) {
        CustomAnnotation* ann = [CustomAnnotation new];
        ann.data = [WaterMachine new];
        ann.data.latitude = [arrLatitude[i] doubleValue];
        ann.data.longitude = [arrLongitude[i] doubleValue];
        ann.data.type = i%6+1;
        ann.data.score = 78.5;
        ann.data.desc = @"Mainly suitable for centralized domestic and drinking water surface water source areas, secondary protection areas, fish and shrimp overwintering grounds, migration channels, aquaculture areas and other fishery waters and swimming areas。At present, the water quality is good and can be used for irrigation and household use. ";
        ann.imageNor = [NSString stringWithFormat:@"water_sel_%d",ann.data.type];
        ann.imageSel = [NSString stringWithFormat:@"water_sel_%d",ann.data.type];
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

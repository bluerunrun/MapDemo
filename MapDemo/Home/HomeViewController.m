//
//  HomeViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "HomeViewController.h"
#import "MPCalloutAnnotationView.h"
#import "ChooseView.h"


#define DefaultCoordinate CLLocationCoordinate2DMake(22.151408, 113.564488)

@interface HomeViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,CalloutViewClickDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapKitView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) NSMutableArray * annotions;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, assign) int selectRangeIndex;

@end

@implementation HomeViewController

#pragma mark -LifeCycle

-(void)dealloc{
    if (self.mapKitView) {
        self.mapKitView.showsUserLocation = NO;
        self.mapKitView.userTrackingMode  = MKUserTrackingModeFollow;
        [self.mapKitView.layer removeAllAnimations];
        [self.mapKitView removeAnnotations:self.mapKitView.annotations];
        self.mapKitView.delegate = nil;
        self.mapKitView = nil;
    }
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate=nil;
        self.locationManager = nil;
    }
    if(self.annotions){
        [self.annotions removeAllObjects];
        self.annotions=nil;
    }
    self.userLocation=nil;
    self.dataList=nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //设置MKMapView
    self.mapKitView.delegate=self;
    self.mapKitView.showsUserLocation=YES;
    self.mapKitView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapKitView.mapType=MKMapTypeStandard;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=9.0) {
        self.mapKitView.showsCompass=NO;
    }
    
    //初始化locationManger管理器对象
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0) {
        //是否具有定位权限
        int status = [CLLocationManager authorizationStatus];
        //    NSLog(@"\nstatus :%d",status);
        if(![CLLocationManager locationServicesEnabled] || status!=kCLAuthorizationStatusAuthorizedAlways || status!=kCLAuthorizationStatusAuthorizedWhenInUse){
            //请求权限
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    
    self.selectRangeIndex=0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -ResponseMethods

- (IBAction)menuAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowMenu" object:nil];
}

- (IBAction)locateAction:(UIButton *)sender {
    
    if (self.userLocation) {
        //        NSLog(@"根據放大level定位到用戶位置");
        [self.mapKitView setCenterCoordinate:self.userLocation.coordinate animated:YES];
    }else{
        //        NSLog(@"定位失败 显示澳门地区");
        [self.mapKitView setCenterCoordinate:DefaultCoordinate animated:YES];
    }
}

- (IBAction)chooseAction:(id)sender {
    __weak __typeof(self)weakSelf = self;
    NSMutableArray *list = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    ChooseView *rangeView=[[ChooseView alloc] initWithFrame:self.view.bounds AndDataList:list];
    [rangeView seleceCell:self.selectRangeIndex];
    [rangeView show:^(int rangeIndex) {
        weakSelf.selectRangeIndex=rangeIndex;
        [weakSelf locateAction:nil];
    }];
}

#pragma mark -PrivateMethods
- (void)setDataList:(NSMutableArray *)pdataList{
    _dataList=pdataList;
    double minLat = 360.0f, maxLat = -360.0f;
    double minLon = 360.0f, maxLon = -360.0f;
    self.annotions=[NSMutableArray array];
    if (_dataList.count > 0) {
        for (NSObject *obj in _dataList) {
//            if ( obj.LATITUDE  < minLat ) minLat = obj.LATITUDE;
//            if ( obj.LATITUDE  > maxLat ) maxLat = obj.LATITUDE;
//            if ( obj.LONGITUDE < minLon ) minLon = obj.LONGITUDE;
//            if ( obj.LONGITUDE > maxLon ) maxLon = obj.LONGITUDE;
            CLLocationDegrees lat = 22.151408;
            CLLocationDegrees lon = 113.564488;
            CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(lat,lon);
            MPAnnotation *annotation= [[MPAnnotation alloc] init];
            annotation.obj = obj;
            annotation.coordinate=coord;
            [self.annotions addObject:annotation];
        }
        
        CLLocationDegrees latitudeDelta,longitudeDelta;
        latitudeDelta = (maxLat - minLat)*1.8;
        longitudeDelta =  (maxLon - minLon)*1.8;
        if(_dataList.count==1){
            latitudeDelta = 0.03;
            longitudeDelta = 0.03;
        }
        if (latitudeDelta<0||latitudeDelta>180) {
            latitudeDelta = 180;
        }
        if (longitudeDelta<0||longitudeDelta>360) {
            longitudeDelta = 360;
        }
        [self.mapKitView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake((minLat+maxLat)/2.0, (minLon+maxLon)/2.0), MKCoordinateSpanMake(latitudeDelta, longitudeDelta)) animated:YES];
    }
    
    [self addAnnotation];
}

- (void)addAnnotation{
    [self removeCustomAnnotation];
    [self.mapKitView addAnnotations:self.annotions];
}

#pragma mark -MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:[MPAnnotation class]]){
        MPCalloutAnnotationView *calloutView=[MPCalloutAnnotationView calloutViewWithMapView:mapView :@"calloutDirCare"];
        calloutView.annotation=annotation;
        calloutView.image=[UIImage imageNamed:@"main_icon_Parking-Metre"];
        calloutView.delegate=self;
        return calloutView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    if ([view.annotation isKindOfClass:[MPAnnotation class]]) {
        [self.mapKitView setCenterCoordinate:view.annotation.coordinate animated:YES];
    }
}

//当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    //    NSLog(@"更新用戶位置");
    self.userLocation = [[CLLocation alloc] initWithLatitude:loc.latitude longitude:loc.longitude];
    NSLog(@"经纬度＝%f,%f",loc.longitude,loc.latitude);
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(nonnull NSError *)error{
    NSLog(@"定位失敗");
    [self locateAction:nil];
}

//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    double level = [self.mapKitView getZoomLevel];
//    NSLog(@"regionDidChangeAnimated level:%f",level);
//}

//#pragma mark -CLLocationManagerDelegate
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    NSLog(@"用戶位置發生改變");
//    self.userLocation = [locations lastObject];
//    NSLog(@"经纬度＝%f,%f",self.userLocation.coordinate.longitude,self.userLocation.coordinate.latitude);
//    [self.mapKitView setCenterCoordinate:self.userLocation.coordinate zoomLevel:self.selectedRange.LEVEL animated:YES];
//}

//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    self.userLocation = nil;
//}

#pragma mark 移除所用自定义大头针
-(void)removeCustomAnnotation{
    [self.mapKitView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MPAnnotation class]]) {
            [self.mapKitView removeAnnotation:obj];
        }
    }];
}

#pragma mark - CalloutViewClickDelegate
-(void)clickPinWithObj:(NSObject *)obj{
    NSLog(@"点击: %@",obj);
}



@end

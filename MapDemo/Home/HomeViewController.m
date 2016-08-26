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
#import "JZLocationConverter.h"


@interface HomeViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapKitView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;

@property (nonatomic, assign) int selectIndex;

@property (nonatomic, assign) BOOL isFixLocation;

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
    self.userLocation=nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self initMap];
    
    self.selectIndex=0;
    self.isFixLocation = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -PrivateMethods

- (void)initMap{
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
    self.locationManager.distanceFilter = 1;//m
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [self.locationManager startUpdatingLocation];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0) {
        //是否具有定位权限
        int status = [CLLocationManager authorizationStatus];
        //    NSLog(@"\nstatus :%d",status);
        if(![CLLocationManager locationServicesEnabled] || status!=kCLAuthorizationStatusAuthorizedAlways || status!=kCLAuthorizationStatusAuthorizedWhenInUse){
            //请求权限
            [self.locationManager requestWhenInUseAuthorization];
        }
    }

}

- (void)goToPosition:(CLLocationCoordinate2D)coordinate{
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.01));
    [self.mapKitView setRegion:region animated:YES];
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
    NSMutableArray *list = [NSMutableArray arrayWithObjects:@"mapView定位",@"Manager定位",@"修正定位偏差", nil];
    ChooseView *rangeView=[[ChooseView alloc] initWithFrame:self.view.bounds AndDataList:list];
    [rangeView seleceCell:self.selectIndex];
    [rangeView show:^(int selectIndex) {
        weakSelf.isFixLocation = NO;
        weakSelf.selectIndex=selectIndex;
        switch (selectIndex) {
            case 0:
            {
                [weakSelf removeAllAnnotation];
                weakSelf.mapKitView.showsUserLocation=YES;
                [weakSelf.locationManager stopUpdatingLocation];
            }
                break;
            case 1:
            {
                [weakSelf removeAllAnnotation];
                weakSelf.mapKitView.showsUserLocation=NO;
                [weakSelf.locationManager startUpdatingLocation];
            }
                break;
            case 2:
            {
                weakSelf.isFixLocation = YES;
                [weakSelf removeAllAnnotation];
                weakSelf.mapKitView.showsUserLocation=NO;
                [weakSelf.locationManager startUpdatingLocation];
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark -MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
   if([annotation isKindOfClass:[UMKAnnotation class]]){
        
        static NSString *ID = @"UMKAnnotationCalloutView";
        MKAnnotationView *calloutView =
        [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (calloutView == nil) {
            calloutView=[[MKAnnotationView alloc] initWithAnnotation:
                      annotation reuseIdentifier:ID];
            // 设置是否显示标题和子标题
            calloutView.canShowCallout = YES;
            calloutView.image = [UIImage imageNamed:@"main_icon_Parking-Metre"];
        }
        return calloutView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [self.mapKitView setCenterCoordinate:view.annotation.coordinate animated:YES];
}

//当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D coordinate = [userLocation coordinate];
    //    NSLog(@"更新用戶位置");
    self.userLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self goToPosition:coordinate];
    NSLog(@"mapView定位更新 经纬度＝%f,%f",coordinate.longitude,coordinate.latitude);
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(nonnull NSError *)error{
    NSLog(@"mapView定位失敗");
    [self locateAction:nil];
}

#pragma mark 移除自定义大头针
-(void)removeAllAnnotation{
    [self.mapKitView removeAnnotations:self.mapKitView.annotations];
}

-(void)removeMPAnnotation{
    [self.mapKitView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MPAnnotation class]]) {
            [self.mapKitView removeAnnotation:obj];
        }
    }];
}

#pragma mark - CoreLocation 代理
#pragma mark -- 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"manager定位更新 经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);

    if (self.isFixLocation) {
        //当使用模拟器定位在中国大陆以外地区，计算GCJ-02坐标还是返回WGS-84
        coordinate = [JZLocationConverter wgs84ToGcj02:coordinate];
        NSLog(@"manager定位加偏 经度：%f,纬度：%f",coordinate.longitude,coordinate.latitude);
    }
    
    [self removeAllAnnotation];
    UMKAnnotation *annotation=[[UMKAnnotation alloc]init];
    annotation.title=@"CMJ Studio";
    annotation.subtitle=@"Kenshin Cui's Studios";
    annotation.coordinate=coordinate;
    [_mapKitView addAnnotation:annotation];
    [self.mapKitView selectAnnotation:annotation animated:YES];
    [self goToPosition:coordinate];
    
    self.userLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"manager 定位失敗");
    [self locateAction:nil];
}

@end

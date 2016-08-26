//
//  FirstViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "FirstViewController.h"
#import "MPCalloutAnnotationView.h"
#import "ChooseView.h"

@interface FirstViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,CalloutViewClickDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapKitView;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) NSMutableArray * annotions;

@property (nonatomic, assign) int selectIndex;

@end

@implementation FirstViewController

-(void)dealloc{
    if (self.mapKitView) {
        self.mapKitView.showsUserLocation = NO;
        self.mapKitView.userTrackingMode  = MKUserTrackingModeFollow;
        [self.mapKitView.layer removeAllAnimations];
        [self.mapKitView removeAnnotations:self.mapKitView.annotations];
        self.mapKitView.delegate = nil;
        self.mapKitView = nil;
    }
    if(self.annotions){
        [self.annotions removeAllObjects];
        self.annotions=nil;
    }
    self.userLocation=nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMap];
    
    self.selectIndex = 0;
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
    
}

- (void)addMPAnnotations{
    
    NSMutableArray *dataList = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        CLLocationDegrees lat = (i%2==0)?(22.151408+0.0003*i):(22.151408-0.0005*i);
        CLLocationDegrees lon = (i%2==0)?(113.564488+0.0008*i):(113.564488-0.0004*i);
        CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(lat,lon);
        MPAnnotation *annotation= [[MPAnnotation alloc] init];
        annotation.coordinate=coord;
        [dataList addObject:annotation];
    }
    
    double minLat = 360.0f, maxLat = -360.0f;
    double minLon = 360.0f, maxLon = -360.0f;
    self.annotions=[NSMutableArray array];
    if (dataList.count > 0) {
        for (MPAnnotation *obj in dataList) {
            if ( obj.coordinate.latitude < minLat ) minLat = obj.coordinate.latitude;
            if ( obj.coordinate.latitude  > maxLat ) maxLat = obj.coordinate.latitude;
            if ( obj.coordinate.longitude < minLon ) minLon = obj.coordinate.longitude;
            if ( obj.coordinate.longitude > maxLon ) maxLon = obj.coordinate.longitude;
            [self.annotions addObject:obj];
        }
        
        CLLocationDegrees latitudeDelta,longitudeDelta;
        latitudeDelta = (maxLat - minLat)*1.8;
        longitudeDelta =  (maxLon - minLon)*1.8;
        if(dataList.count==1){
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
    
    [self removeMPAnnotation];
    [self.mapKitView addAnnotations:self.annotions];
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
    NSMutableArray *list = [NSMutableArray arrayWithObjects:@"自定义CalloutView",@"1",@"2", nil];
    ChooseView *rangeView=[[ChooseView alloc] initWithFrame:self.view.bounds AndDataList:list];
    [rangeView seleceCell:self.selectIndex];
    [rangeView show:^(int selectIndex) {
        weakSelf.selectIndex=selectIndex;
        switch (selectIndex) {
            case 0:
            {
                [weakSelf addMPAnnotations];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark -MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:[MPAnnotation class]]){
        MPCalloutAnnotationView *calloutView=[MPCalloutAnnotationView calloutViewWithMapView:mapView :@"MPAnnotationCalloutView"];
        calloutView.annotation=annotation;
        calloutView.image=[UIImage imageNamed:@"main_icon_Parking-Metre"];
        calloutView.delegate=self;
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


#pragma mark - CalloutViewClickDelegate

-(void)clickPinWithObj:(NSObject *)obj{
    NSLog(@"点击: %@",obj);
}

#pragma mark --移除自定义大头针

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

@end

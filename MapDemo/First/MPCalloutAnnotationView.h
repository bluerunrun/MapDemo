//
//  MPCalloutAnnotationView.h
//  EasyMeter
//
//  Created by guopu on 26/7/16.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MPAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) NSObject *obj;
@property (nonatomic, assign) BOOL draggable;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end


@protocol CalloutViewClickDelegate <NSObject>

-(void)clickPinWithObj:(NSObject *)obj;

@end

@interface MPCalloutAnnotationView : MKAnnotationView

+(instancetype)calloutViewWithMapView:(MKMapView *)mapView :(NSString *)key;

@property (weak, nonatomic) id<CalloutViewClickDelegate> delegate;

@end

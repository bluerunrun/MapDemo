//
//  UMKAnnotation.h
//  MapDemo
//
//  Created by guopu on 26/8/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import <MapKit/MapKit.h>


@interface UMKAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

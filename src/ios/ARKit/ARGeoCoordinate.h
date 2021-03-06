//
//  ARGeoCoordinate.h
//  AR Kit
//
//  Created by Haseman on 8/1/09.
//  Modified by Ed Rackham (a1phanumeric) 2013
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ARCoordinate.h"

@interface ARGeoCoordinate : ARCoordinate

@property (nonatomic, retain) CLLocation *geoLocation;
@property (nonatomic, retain) UIView *displayView;
@property (nonatomic) double distanceFromOrigin;


- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;

+ (ARGeoCoordinate *)coordinateWithLocation:(CLLocation *)location locationTitle:(NSString *)titleOfLocation;
+ (ARGeoCoordinate *)coordinateWithLocation:(CLLocation *)location fromOrigin:(CLLocation *)origin;
+ (ARGeoCoordinate *)coordinateWithLocationB:(CLLocation *)location
                              locationTitle:(NSString *)titleOfLocation
                                 locationID:(NSString *)idOfLocation
                               locationKind:(NSString *)kindOfLocation
                              locationImage:(NSString *)imageOfLocation;

- (void)calibrateUsingOrigin:(CLLocation *)origin;

@end

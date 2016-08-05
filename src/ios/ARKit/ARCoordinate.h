//
//  ARCoordinate.h
//  AR Kit
//
//  Created by Zac White on 8/1/09.
//  Modified by Ed Rackham (a1phanumeric) 2013
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (x * (180.0/M_PI))

@interface ARCoordinate : NSObject

- (NSUInteger)hash;
- (BOOL)isEqual:(id)other;
- (BOOL)isEqualToCoordinate:(ARCoordinate *)otherCoordinate;

+ (ARCoordinate *)coordinateWithRadialDistance:(double)newRadialDistance inclination:(double)newInclination azimuth:(double)newAzimuth;

@property (nonatomic, retain)	NSString *title;
@property (nonatomic, retain)	NSString *subtitle;
@property (nonatomic, retain)	NSString *imageURL;
@property (nonatomic, retain)	NSString *id;
@property (nonatomic, retain)	NSString *kind;
@property (nonatomic) double	radialDistance;
@property (nonatomic) double	inclination;
@property (nonatomic) double	azimuth;

@end

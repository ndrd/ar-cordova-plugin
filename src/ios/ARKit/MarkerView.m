//
//  CoordinateView.m
//  ARKitDemo
//
//  Modified by Niels W Hansen on 12/31/11.
//  Modified by Ed Rackham (a1phanumeric) 2013
//

#import "ARViewProtocol.h"
#import "ARGeoCoordinate.h"
#import "MarkerView.h"
#import <QuartzCore/QuartzCore.h>

#define LABEL_HEIGHT        20
#define LABEL_MARGIN        15
#define DISCLOSURE_MARGIN   10
#define LOGO_SIZE           50

@implementation MarkerView{
    BOOL                    _allowsCallout;
    UIImage                 *_bgImage;
    UIImage                 *_logoImage;
    UILabel                 *_lblDistance;
    id<ARMarkerDelegate>    _delegate;
    ARGeoCoordinate         *_coordinateInfo;
}

- (id)initForCoordinate:(ARGeoCoordinate *)coordinate withDelgate:(id<ARMarkerDelegate>)aDelegate{
    return [self initForCoordinate:coordinate withDelgate:aDelegate allowsCallout:YES];
}

- (id)initForCoordinate:(ARGeoCoordinate *)coordinate withDelgate:(id<ARMarkerDelegate>)aDelegate allowsCallout:(BOOL)allowsCallout{
    
    _coordinateInfo = coordinate;
    _delegate       = aDelegate;
    _allowsCallout  = allowsCallout;
    _bgImage        = [UIImage imageNamed:@"bgCallout.png"];
    
    _logoImage = [UIImage imageWithData: [
                                          NSData dataWithContentsOfURL: [NSURL URLWithString:coordinate.imageURL]]];
    
    
    
    
    
    UIImage *disclosureImage    = [UIImage imageNamed:@"bgCalloutDisclosure.png"];
    CGSize calloutSize          = _bgImage.size;
    CGRect theFrame             = CGRectMake(0, 0, calloutSize.width + LOGO_SIZE, LOGO_SIZE + 2 * LABEL_MARGIN);
    
    
    
    if(self = [super initWithFrame:theFrame]){
        CALayer *layer = [self layer];
        layer.cornerRadius = 5;
        layer.shadowOffset = CGSizeMake(5.0, 5.0);
        
        
        [self setContentMode:UIViewContentModeScaleAspectFit];
        [self setAutoresizesSubviews:YES];
        
        if(_allowsCallout){
            [self setUserInteractionEnabled:YES];
        }
        
        /*
         UIImageView *logoImageView = [[UIImageView alloc] initWithImage:_logoImage];
         logoImageView.contentMode = UIViewContentModeScaleAspectFit;
         [self addSubview:logoImageView];
         */
        
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            [self setBackgroundColor:[UIColor clearColor]];
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            [blurEffectView setFrame: [self bounds]];
            //blurEffectView.frame = [self bounds];
            //blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            [self addSubview:blurEffectView];
        } else {
            [self setBackgroundColor:[UIColor blackColor]];
        }
        
        UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DISCLOSURE_MARGIN, DISCLOSURE_MARGIN, LOGO_SIZE, LOGO_SIZE)];
        [logoImageView setContentMode: UIViewContentModeScaleAspectFit];
        
        [logoImageView setImage:_logoImage];
        [self addSubview:logoImageView];
        
        //UIImageView *bgImageView = [[UIImageView alloc] initWithImage:_bgImage];
        //[self addSubview:bgImageView];
        
        CGSize labelSize = CGSizeMake(calloutSize.width - (DISCLOSURE_MARGIN), LABEL_HEIGHT);
        
        if(_allowsCallout){
            labelSize.width -= disclosureImage.size.width + (DISCLOSURE_MARGIN);
        }
        
        UILabel *titleLabel	= [[UILabel alloc] initWithFrame:CGRectMake(LABEL_MARGIN + LOGO_SIZE, LABEL_MARGIN, labelSize.width, labelSize.height)];
        [titleLabel setBackgroundColor: [UIColor clearColor]];
        [titleLabel setTextColor:		[UIColor whiteColor]];
        [titleLabel setTextAlignment:	NSTextAlignmentCenter];
        [titleLabel setFont:            [UIFont fontWithName:@"Helvetica-Bold" size:20.0]];
        [titleLabel setText:			[coordinate title]];
        [self addSubview:titleLabel];
        
        NSLocale *locale = [NSLocale currentLocale];
        _usesMetric = [[locale objectForKey:NSLocaleUsesMetricSystem] boolValue];
        
        
        _lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_MARGIN * 3, LABEL_HEIGHT + LABEL_MARGIN, labelSize.width, labelSize.height)];
        [_lblDistance setBackgroundColor:    [UIColor clearColor]];
        [_lblDistance setTextColor:          [UIColor whiteColor]];
        [_lblDistance setTextAlignment:      NSTextAlignmentCenter];
        [_lblDistance setFont:               [UIFont fontWithName:@"Helvetica" size:13.0]];
        if(_usesMetric == YES){
            [_lblDistance setText:[NSString stringWithFormat:@"%.2f km", [_coordinateInfo distanceFromOrigin]]];
        } else {
            [_lblDistance setText:[NSString stringWithFormat:@"%.2f mi", ([_coordinateInfo distanceFromOrigin]/1000.0f) * 0.621371]];
        }
        [self addSubview:_lblDistance];
        
        
        if(_allowsCallout){
            UIImageView *disclosureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(calloutSize.width + DISCLOSURE_MARGIN, DISCLOSURE_MARGIN, disclosureImage.size.width, disclosureImage.size.height)];
            [disclosureImageView setImage:[UIImage imageNamed:@"bgCalloutDisclosure.png"]];
            [self addSubview:disclosureImageView];
        }
        
        
    }
    
    return self;
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if(_usesMetric == YES){
        [_lblDistance setText:[NSString stringWithFormat:@"%.2f m", [_coordinateInfo distanceFromOrigin]]];
    } else {
        [_lblDistance setText:[NSString stringWithFormat:@"%.2f mi", ([_coordinateInfo distanceFromOrigin]/1000.0f) * 0.621371]];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_delegate didTapMarker:_coordinateInfo];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect theFrame = CGRectMake(0, 0, _bgImage.size.width, _bgImage.size.height);
    if(CGRectContainsPoint(theFrame, point))
        return YES; // touched the view;
    
    return NO;
}

@end

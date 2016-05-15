//
//  MapViewController.h
//  Eradat
//
//  Created by Soomro Shahid on 7/2/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : BaseController<MKMapViewDelegate,  CLLocationManagerDelegate, GMSMapViewDelegate>
{
    __weak IBOutlet MKMapView* routeMapView;
    CLLocationManager *locationManager;
    __weak IBOutlet UIView* viewDetail;
    __weak IBOutlet UIButton* btnFavourite;
}
@property(nonatomic,assign)BOOL isFavourite;
@property(nonatomic,strong) Favoriteschedule* favourite;
@property(nonatomic,strong) IBOutlet GMSMapView *mapView;
@property(nonatomic,strong) Journey* journeyDetail;
@property (nonatomic, strong) MKPolyline *routeLine; //your line
@property (nonatomic, strong) MKPolylineView *routeLineView; //overlay view
@end

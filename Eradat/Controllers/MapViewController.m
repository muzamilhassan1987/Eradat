//
//  MapViewController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/2/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "MapViewController.h"
#import "MyPlace.h"
#import "MapCalloutView.h"
#import "RMUniversalAlert.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <CLLocationManagerDelegate>
{
    MapCalloutView *currentCalloutView;
    RouteBusStopsInfo *selectedBusStop;
    GMSPolyline *currentLocationRoute;
    GMSMarker *selectedMarker;
    GMSMarker *userLocation;
    CLLocationCoordinate2D userCurrentLocation;
    
    int currentRouteIndex;
    NSMutableArray *allRoutesToDraw;
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation MapViewController
@synthesize isFavourite,favourite,journeyDetail;

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
//    [appDelegate addSideMenuController];
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
//    [appDelegate removeSideMenuController];
    self.routeLine = nil;
    self.routeLineView = nil;
    [routeMapView removeFromSuperview];
    routeMapView = nil;
    
}


- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerMapView;
    [super viewDidLoad];
    
    //initialize your map view and add it to your view hierarchy - **set its delegate to self***
    
    [self getCurrentLocation];
    CLLocationCoordinate2D coordinateArray[self.journeyDetail.routeBusStopsInfo.count];
    
//    [routeMapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    currentRouteIndex = 0;
    allRoutesToDraw = [NSMutableArray new];
//    [routeMapView setMapType:MKMapTypeSatellite];
    
    
    userCurrentLocation = CLLocationCoordinate2DMake(-1, -1);
    
    
    int index = 0;
    for (RouteBusStopsInfo *route in self.journeyDetail.routeBusStopsInfo) {
        
        coordinateArray[index] = CLLocationCoordinate2DMake(route.busStopLat.doubleValue, route.busStopLong.doubleValue);
        index++;
    }
    
    
    
    for (int i = 0 ; i < self.journeyDetail.routeBusStopsInfo.count ; i++){
        
        CLLocationCoordinate2D cor = coordinateArray[i];
        
//        MyPlace *place=[[MyPlace alloc] initWithCoordinate:cor];
//        place.stopInfo = [self.journeyDetail.routeBusStopsInfo objectAtIndex:i];
//
//        [routeMapView addAnnotation:place];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:cor.latitude
                                                                longitude:cor.longitude
                                                                     zoom:10];
        
        MyPlace *marker = [[MyPlace alloc] init];
        marker.position = camera.target;
        marker.icon = [UIImage imageNamed:@"buspin"];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.stopInfo = [self.journeyDetail.routeBusStopsInfo objectAtIndex:i];
        marker.map = self.mapView;
        
        [self.mapView setCamera:camera];
        //i=i+8;
        
        if (i < self.journeyDetail.routeBusStopsInfo.count - 1) {
            
            CLLocationCoordinate2D endCoord = coordinateArray[i + 1];
            NSDictionary *dictionary = @{@"sourceLat" : [NSString stringWithFormat:@"%f", cor.latitude],
                                         @"sourceLong" : [NSString stringWithFormat:@"%f", cor.longitude],
                                         @"destinationLat" : [NSString stringWithFormat:@"%f", endCoord.latitude],
                                         @"destinationLong" : [NSString stringWithFormat:@"%f", endCoord.longitude]};
            
            [allRoutesToDraw addObject:dictionary];
        }
        
    }

    
    
    CLLocationCoordinate2D startCoord = coordinateArray[0];
    MKCoordinateRegion adjustedRegion = [routeMapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 1000, 1000)];
    adjustedRegion.span.latitudeDelta = 0.2f;
    adjustedRegion.span.longitudeDelta = 0.2f;

    [routeMapView setRegion:adjustedRegion animated:YES];
    
    
    
    [self setBottomViewDetail];
    
    currentRouteIndex = 0;
    if ([allRoutesToDraw count] > 0) {
        
        [self drawRoute:allRoutesToDraw[0]];
    }
}

-(void) drawRoute:(NSDictionary *) endPoints {
    
    NSString *sourceLat     = endPoints[@"sourceLat"];
    NSString *sourceLong    = endPoints[@"sourceLong"];
    NSString *destLat       = endPoints[@"destinationLat"];
    NSString *destLong      = endPoints[@"destinationLong"];

    
    NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", sourceLat.doubleValue,  sourceLong.doubleValue, destLat.doubleValue, destLong.doubleValue];
    NSLog(@"baseURL:%@", baseUrl);
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url:%@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            NSError *error = nil;
            
            if (connectionError && data == nil) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                return;
            }
            if (data == nil) {
                return;
            }
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSLog(@"result:%@", result);
            
            NSArray *routes = [result objectForKey:@"routes"];
//            NSLog(@"routes:%@", routes);
            if ([routes count] > 0) {
                
                NSDictionary *firstRoute = [routes objectAtIndex:0];
                
                if ([firstRoute count] > 0) {
                    
                    
                    NSDictionary *leg =  [[firstRoute objectForKey:@"legs"] objectAtIndex:0];
                    
                    
                    NSArray *steps = [leg objectForKey:@"steps"];
                    if ([steps count] > 0) {
                        
                        int stepIndex = 0;
                        
                        CLLocationCoordinate2D stepCoordinates[[steps count]];
//                        NSLog(@"steps:%@", steps);
                        GMSMutablePath *path = [GMSMutablePath path];
                        for (NSDictionary *step in steps) {
                            
                            NSDictionary *start_location = [step objectForKey:@"start_location"];
                            stepCoordinates[stepIndex++] = [self coordinateWithLocation:start_location];
                            [path addCoordinate: [self coordinateWithLocation:start_location]];
                            
                            if ([steps count] == stepIndex){
                                NSDictionary *end_location = [step objectForKey:@"end_location"];
                                stepCoordinates[stepIndex++] = [self coordinateWithLocation:end_location];
                                
                                [path addCoordinate: [self coordinateWithLocation:end_location]];
                            }
                        }
                        

                        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
                        polyline.strokeColor = [UIColor blueColor];
                        polyline.strokeWidth = 5.f;
                        polyline.map = self.mapView;
                    }
                    NSLog(@"1");
                    
                }
                NSLog(@"2");
                
            }
            NSLog(@"3");
            
            currentRouteIndex++;
            NSLog(@"4");
            
            if([allRoutesToDraw count] > currentRouteIndex) {
                
                NSLog(@"5");
                [self performSelectorOnMainThread:@selector(drawRoute:)
                                       withObject:[allRoutesToDraw objectAtIndex:currentRouteIndex]
                                    waitUntilDone:true];
            }
            NSLog(@"6");
        });
        
        
    }];


}


- (CLLocationCoordinate2D)coordinateWithLocation:(NSDictionary*)location
{
    double latitude = [[location objectForKey:@"lat"] doubleValue];
    double longitude = [[location objectForKey:@"lng"] doubleValue];
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}

-(void) drawRouteFromCurrentLocation:(CLLocationCoordinate2D) destination {
    
    NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", userCurrentLocation.latitude,  userCurrentLocation.longitude, destination.latitude, destination.longitude];
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            
            NSError *error = nil;
            if (connectionError && data == nil) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                return;
            }
            if (data == nil) {
                return;
            }
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            [self performSelectorOnMainThread:@selector(drawCurrentLocationRouteFromResult:)
                                   withObject:result
                                waitUntilDone:true];
        });
        
        
    }];
}

-(void) drawCurrentLocationRouteFromResult:(NSDictionary *) result {
    
//    NSLog(@"result route:%@", result);
    NSArray *routes = [result objectForKey:@"routes"];
    
    
    if ([routes count] > 0) {
        
        NSDictionary *firstRoute = [routes objectAtIndex:0];
        
        NSArray *legs = [firstRoute objectForKey:@"legs"];
        if([legs count] == 0) {
            SIMPLE_ALERT([MCLocalization stringForKey:@"Error"], [MCLocalization stringForKey:@"Could not get direction"]);
            return;
        }
        
        NSDictionary *leg =  [legs objectAtIndex:0];
        
        
        NSArray *steps = [leg objectForKey:@"steps"];
        GMSMutablePath *path =[GMSMutablePath path];
        if ([steps count] > 0) {
            
            int stepIndex = 0;
            
            CLLocationCoordinate2D stepCoordinates[[steps count]];
            
            for (NSDictionary *step in steps) {
                
                NSDictionary *start_location = [step objectForKey:@"start_location"];
                stepCoordinates[stepIndex++] = [self coordinateWithLocation:start_location];
                [path addCoordinate:[self coordinateWithLocation:start_location]];
                
                if ([steps count] == stepIndex){
                    NSDictionary *end_location = [step objectForKey:@"end_location"];
                    stepCoordinates[stepIndex++] = [self coordinateWithLocation:end_location];
                    [path addCoordinate:[self coordinateWithLocation:end_location]];
                }
            }
            
            
            if (currentLocationRoute) {
                currentLocationRoute.map = nil;
            }
            GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeColor = [UIColor redColor];
            polyline.strokeWidth = 5.f;
            polyline.map = self.mapView;
            currentLocationRoute = polyline;
            
//                if (self.routeLine) {
//                    [routeMapView removeOverlay:self.routeLine];
//                    self.routeLine = nil;
//                }
//                
//                self.routeLine = [MKPolyline polylineWithCoordinates:stepCoordinates count:stepIndex - 1];
//                [routeMapView addOverlay:self.routeLine];
//            
//            [routeMapView setNeedsDisplay];

        }
        
        
        
    }
}

-(void)setBottomViewDetail {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    
    UILabel* lblBusNo = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblBusNo];
    UILabel* lblDriverName = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDriverName];
    UILabel* lblLocFrom = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocFrom];
    UILabel* lblLocTo = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocTo];
    UILabel* lblDays = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDays];
    UILabel* lblVacations = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblVacations];
    UILabel* lblStartTime = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblStartTime];
    UILabel* lblEndTime = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblEndTime];
    
    UILabel* lblBusNoTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblBusNo+100];
    UILabel* lblDriverNameTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDriverName+100];
    UILabel* lblLocFromTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocFrom+100];
    UILabel* lblLocToTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocTo+100];
    UILabel* lblDaysTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDays+100];
    UILabel* lblVacationsTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblVacations+100];
    UILabel* lblStartTimeTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblStartTime+100];
    UILabel* lblEndTimeTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblEndTime+100];
    
    if (!singleton.isEnglish) {
        
        lblBusNo = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblBusNo + 100];
        lblDriverName = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDriverName + 100];
         lblLocFrom = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocFrom + 100];
         lblLocTo = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocTo + 100];
         lblDays = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDays + 100];
         lblVacations = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblVacations + 100];
         lblStartTime = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblStartTime + 100];
         lblEndTime = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblEndTime + 100];
        
         lblBusNoTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblBusNo];
         lblDriverNameTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDriverName];
         lblLocFromTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocFrom];
         lblLocToTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblLocTo];
         lblDaysTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblDays];
         lblVacationsTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblVacations];
         lblStartTimeTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblStartTime];
         lblEndTimeTitle = (UILabel*)[viewDetail viewWithTag:eJourneyCellLblEndTime ];
    }
    
    [lblBusNoTitle setText:[MCLocalization stringForKey:@"Bus #:"]];
    [lblDriverNameTitle setText:[MCLocalization stringForKey:@"Driver Name:"]];
    [lblLocFromTitle setText:[MCLocalization stringForKey:@"Location From:"]];
    [lblLocToTitle setText:[MCLocalization stringForKey:@"Location To:"]];
    [lblDaysTitle setText:[MCLocalization stringForKey:@"Days:"]];
    [lblVacationsTitle setText:[MCLocalization stringForKey:@"Vacations:"]];
    [lblStartTimeTitle setText:[MCLocalization stringForKey:@"Start Time:"]];
    [lblEndTimeTitle setText:[MCLocalization stringForKey:@"End Time:"]];
    
    if (isFavourite) {
        //[btnFavourite setHidden:YES];
        [lblBusNo setText:favourite.busLicenseNumber];
        [lblDriverName setText:favourite.driverName];
        if(singleton.isEnglish){
            [lblLocFrom setText:favourite.busStopFromTitleEn];
            [lblLocTo setText:favourite.busStopToTitleEn];
        }
        else{
            [lblLocFrom setText:favourite.busStopFromTitleAr];
            [lblLocTo setText:favourite.busStopToTitleAr];
        }
        
        [lblDays setText:@""];
        [lblVacations setText:@""];
//        NSTimeInterval timestampDate = (NSTimeInterval)favourite.scheduleEffectiveStartDate;
//        NSDate *StartDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
//        
//        timestampDate = (NSTimeInterval)favourite.scheduleEffectiveEndDate;
//        NSDate *EndDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
        
        [lblStartTime setText:favourite.scheduleEffectiveStartDateString];
        [lblEndTime setText:favourite.scheduleEffectiveEndDateString];
    }
    else {
        [lblBusNo setText:journeyDetail.busLicenseNumber];
        [lblDriverName setText:journeyDetail.driverName];
        if (singleton.isEnglish) {
            [lblLocFrom setText:journeyDetail.busStopFromTitleEn];
            [lblLocTo setText:journeyDetail.busStopToTitleEn];
        }
        else{
            [lblLocFrom setText:journeyDetail.busStopFromTitleAr];
            [lblLocTo setText:journeyDetail.busStopToTitleAr];
        }
        
        [lblDays setText:[journeyDetail.scheduleRecurringDays componentsJoinedByString:@","]];
        [lblVacations setText:@""];
        [lblVacationsTitle setHidden:YES];
        [lblVacations setHidden:YES];
//        NSTimeInterval timestampDate = (NSTimeInterval)journeyDetail.scheduleEffectiveStartDate;
//        NSDate *StartDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
//        
//        timestampDate = (NSTimeInterval)journeyDetail.scheduleEffectiveEndDate;
//        NSDate *EndDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
//        
//        [lblStartTime setText:[formatter stringFromDate:StartDate]];
//        [lblEndTime setText:[formatter stringFromDate:EndDate]];
        [lblStartTime setText:journeyDetail.scheduleEffectiveStartDateString];
        [lblEndTime setText:journeyDetail.scheduleEffectiveEndDateString];

    }
    
    if(self.isFavourite) {
        [btnFavourite setTitle:[MCLocalization stringForKey:@"REMOVE FAVOURITE"] forState:UIControlStateNormal];
    }
    else {
        [btnFavourite setTitle:[MCLocalization stringForKey:@"MARK AS FAVOURITE"] forState:UIControlStateNormal];
    }
    
    
    
    [self iterateSubViewsForLocalization:viewDetail];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
    
    MKAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"Annotation";
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        //pinView.pinColor = MKPinAnnotationColorGreen;
        pinView.canShowCallout = NO;
        //pinView.animatesDrop = YES;
        RouteBusStopsInfo *stop = [(MyPlace *)annotation stopInfo];
        MapCalloutView *callout = [[[NSBundle mainBundle] loadNibNamed:@"MapCalloutView"
                                                                 owner:nil
                                                               options:nil] objectAtIndex:0];
        
        callout.busStopLabel.text = [Singleton sharedSingletonInstance].isEnglish ? stop.busStopTitleEn : stop.busStopTitleAr;
        
        
        pinView.leftCalloutAccessoryView = callout;
        
        pinView.image = [UIImage imageNamed:@"buspin"];    //as suggested by Squatch
    }
    else {
        [mapView.userLocation setTitle:@"I am here"];
    }
    return pinView;
}

-(UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
//    CGPoint point = [self.mapView.projection pointForCoordinate:marker.position];
    if (marker == userLocation) {
        return nil;
    }
    
    RouteBusStopsInfo *stop = [(MyPlace *)marker stopInfo];
    MapCalloutView *callout = [[[NSBundle mainBundle] loadNibNamed:@"MapCalloutView"
                                                             owner:nil
                                                           options:nil] objectAtIndex:0];
    [callout setBackgroundColor:[UIColor clearColor]];
    
    callout.busStopLabel.text = [Singleton sharedSingletonInstance].isEnglish ? stop.busStopTitleEn : stop.busStopTitleAr;
    
//    [(MyPlace *)marker setCalloutView:callout];
    currentCalloutView = callout;
    selectedBusStop = stop;
    
    if (selectedMarker && marker == selectedMarker) {
        
        CLLocationCoordinate2D stopCoordinates = CLLocationCoordinate2DMake(selectedBusStop.busStopLat.doubleValue, selectedBusStop.busStopLong.doubleValue);
        CLLocation *userLoc = [[CLLocation alloc] initWithLatitude:userCurrentLocation.latitude longitude:userCurrentLocation.longitude];
        CLLocation *stopLoc = [[CLLocation alloc] initWithLatitude:stopCoordinates.latitude longitude:stopCoordinates.longitude];
        
        CLLocationDistance distance = [stopLoc distanceFromLocation:userLoc];
        [callout.totalDistanceLabel setText:
         [NSString stringWithFormat:@"DISTANCE\n%.3lf Km", distance /  1000]];
        [self getDirectionButtonPressed:[callout directionButton]];
    }
    
//    NSLog(@"callout:%@", callout);
    
    return callout;

}

-(void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    

    RouteBusStopsInfo *stop = [(MyPlace *)marker stopInfo];
    selectedBusStop = stop;
//    NSLog(@"callout:%@", [(MyPlace *)marker calloutView]);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:marker.position.latitude
                                                            longitude:marker.position.longitude
                                                                 zoom:10];
    
    MyPlace *newMarker = [[MyPlace alloc] init];
    newMarker.position = camera.target;
    newMarker.icon = [UIImage imageNamed:@"buspin"];
    newMarker.appearAnimation = kGMSMarkerAnimationPop;
    newMarker.stopInfo = [(MyPlace *)marker stopInfo];
    selectedMarker = newMarker;
    newMarker.map = self.mapView;
    
//    [self.mapView setCamera:camera];
    [self.mapView setSelectedMarker:newMarker];
    
    marker.map = nil;
}

-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    
    if(view.annotation != mapView.userLocation){
        
        
        if (currentCalloutView) {
            [currentCalloutView removeFromSuperview];
            currentCalloutView = nil;
        }
        CGRect frame = view.frame;
        
        RouteBusStopsInfo *stop = [(MyPlace *)view.annotation stopInfo];
        selectedBusStop = stop;
        MapCalloutView *callout = [[[NSBundle mainBundle] loadNibNamed:@"MapCalloutView"
                                                                 owner:nil
                                                               options:nil] objectAtIndex:0];
        
        callout.busStopLabel.text = [Singleton sharedSingletonInstance].isEnglish ? stop.busStopTitleEn : stop.busStopTitleAr;
        [callout.directionButton addTarget:self
                                    action:@selector(getDirectionButtonPressed:)
                          forControlEvents:UIControlEventTouchUpInside];
        callout.center = frame.origin;
        callout.backgroundColor = [UIColor clearColor];
        [self.view addSubview:callout];
        
        currentCalloutView = callout;
    }
}


-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    NSLog(@"viewForOverlay delegate");
    if(overlay != self.routeLine)
    {
        MKPolylineView *line = [[MKPolylineView alloc] initWithPolyline:overlay];
        line.fillColor = [UIColor blueColor];
        line.strokeColor = [UIColor blueColor];
        line.lineWidth = 8;
        NSLog(@"returning line:%@", line);
        return line;
    }
    else {
        
        if (self.routeLineView != nil) {
            
            [self.routeLineView removeFromSuperview];
            self.routeLineView = nil;
            
        }
        self.routeLineView = [[MKPolylineView alloc] initWithPolyline:overlay];
        self.routeLineView.fillColor = [UIColor redColor];
        self.routeLineView.strokeColor = [UIColor redColor];
        self.routeLineView.alpha = 0.7;
        self.routeLineView.lineWidth = 10;
        
        return self.routeLineView;
    }
    
    return nil;
}

-(void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if (currentCalloutView) {
        
        [currentCalloutView removeFromSuperview];
        currentCalloutView = nil;
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500);
//    [routeMapView setRegion:[routeMapView regionThatFits:region] animated:YES];

    userCurrentLocation = userLocation.coordinate;
}

-(void) getCurrentLocation {
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    if ([[UIDevice currentDevice] systemVersion].doubleValue >= 8.0) {
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManager delegate

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if ([locations count] > 0) {
        
        [self.locationManager stopUpdatingLocation];
        self.locationManager = nil;
        
        CLLocation *location = locations[0];
        userCurrentLocation = location.coordinate;
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:userCurrentLocation.latitude
                                                                longitude:userCurrentLocation.longitude
                                                                     zoom:10];
        
        MyPlace *newMarker = [[MyPlace alloc] init];
        newMarker.position = camera.target;
        newMarker.currentTitle = @"My Location";
        newMarker.appearAnimation = kGMSMarkerAnimationPop;
        userLocation = newMarker;
        newMarker.map = self.mapView;
        
    }
    
    
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"err:%@",[error localizedDescription]);
}


-(void) getDirectionButtonPressed:(id) sender {
    
    if ((int)userCurrentLocation.latitude == -1 && (int) userCurrentLocation.longitude == -1) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Couldn't detect your location, make sure you have allowed the location in privacy"]);
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"button_getDistance"]
                                  forState:UIControlStateNormal];
    [(UIButton *)sender setUserInteractionEnabled:NO];
    
    CLLocationCoordinate2D stopCoordinates = CLLocationCoordinate2DMake(selectedBusStop.busStopLat.doubleValue, selectedBusStop.busStopLong.doubleValue);
    CLLocation *userLoc = [[CLLocation alloc] initWithLatitude:userCurrentLocation.latitude longitude:userCurrentLocation.longitude];
    CLLocation *stopLoc = [[CLLocation alloc] initWithLatitude:stopCoordinates.latitude longitude:stopCoordinates.longitude];
    
    CLLocationDistance distance = [stopLoc distanceFromLocation:userLoc];
    [currentCalloutView.totalDistanceLabel setText:
     [NSString stringWithFormat:@"DISTANCE\n%.3lf Km", distance /  1000]];
    
    [self drawRouteFromCurrentLocation:stopLoc.coordinate];
}

-(void) setUpMap {
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //#ifdef __IPHONE_8_0
    //    if(IS_OS_8_OR_LATER) {
    //        // Use one or the other, not both. Depending on what you put in info.plist
    //        [locationManager requestWhenInUseAuthorization];
    //        [locationManager requestAlwaysAuthorization];
    //    }
    //#endif
    
    
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    
    routeMapView.showsUserLocation = YES;
    [routeMapView setMapType:MKMapTypeStandard];
    [routeMapView setZoomEnabled:YES];
    [routeMapView setScrollEnabled:YES];
    
    
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    //NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    //    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    //    region.center.latitude = locationManager.location.coordinate.latitude;
    //    region.center.longitude = locationManager.location.coordinate.longitude;
    //    region.span.longitudeDelta = 0.5f;
    //    region.span.longitudeDelta = 0.5f;
    //    [routeMapView setRegion:region animated:YES];
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(49, -123);
    MKCoordinateRegion adjustedRegion = [routeMapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
    [routeMapView setRegion:adjustedRegion animated:YES];
}


- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f, %f", locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", locationManager.location.altitude];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)FavouritePressed{
    
    if(self.isFavourite) {
        [self removeFromFavourite];
    }
    else {
        [self Favourite];
    }
    
}


-(void)Favourite {
    //checksum, userId, fkscheduleId, timestamp
//    UIButton* btn_Sender = (UIButton*)sender;
//    //NSInteger tag = btn_Sender.tag;
//    NSInteger row = [objc_getAssociatedObject(btn_Sender, &selectedBtn) integerValue];
//    Journey* journeyDetail = [objAllJourneyDetail.journey objectAtIndex:row];
//    NSLog(@"%f",journeyDetail.scheduleId);
    
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@fkscheduleId=%.0f%@",TIMESTAMP,singleton.myAccountInfo.user.userId,journeyDetail.scheduleId,API_KEY];
    NSLog(@"%@",check);
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    [parameters insertObject:[NSString stringWithFormat:@"%.0f",journeyDetail.scheduleId] forKey:@"fkscheduleId" atIndex:3];
    NSLog(@"%@",parameters);
    
    [SERVICE_MODEL addFavourite:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@",response);
        if ([[response valueForKey:@"status"] integerValue] == 200) {
            SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Add To Favourite Successfully"])
        }
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

-(void) removeFromFavourite {
    
    Favoriteschedule* favourite = self.favourite;
    
    [RMUniversalAlert showAlertInViewController:self withTitle:[MCLocalization stringForKey:@"Alert"] message:[MCLocalization stringForKey:@"Are you sure, you want to remove favorite?"] cancelButtonTitle:[MCLocalization stringForKey:@"No"] destructiveButtonTitle:nil otherButtonTitles:@[[MCLocalization stringForKey:@"Yes"]] tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex) {
        
        if (buttonIndex != alert.cancelButtonIndex) {
            
            NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@fkscheduleId=%.0f%@",TIMESTAMP,singleton.myAccountInfo.user.userId,favourite.scheduleId,API_KEY];
            NSLog(@"%@",check);
            
            OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
            [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
            [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
            [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
            [parameters insertObject:[NSString stringWithFormat:@"%.0f",favourite.scheduleId] forKey:@"fkscheduleId" atIndex:3];
            
            NSLog(@"%@",parameters);
            
            [SERVICE_MODEL deleteFavourite:parameters completionBlock:^(NSObject *response) {
                
                NSLog(@"%@",response);
                if ([[response valueForKey:@"status"] integerValue] == 200) {

                    SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Delete From Favourite Successfully"])
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } failureBlock:^(NSError *error) {
                
                NSLog(@"%@",error);
            }];
        }
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 6/14/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "HomeViewController.h"
#import "forgetViewController.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate,UIActionSheetDelegate>{
     BOOL recordResults;
    NSString*logintime;
    NSString*devicename;
    NSString*devicenumber;
    CLLocationManager*locationmanager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString*Naddress;
  
}
@property(strong,nonatomic)CLLocationManager*locationmanager;
@property(strong,nonatomic)CLGeocoder *geocoder;
@property(strong,nonatomic)CLPlacemark *placemark;
/* xmlparser*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;
@property(strong,nonatomic)NSString*logindevice;
@property (strong, nonatomic) IBOutlet UITextField *usernametxt;
@property (strong, nonatomic) IBOutlet UITextField *passwrdtxt;


@property(strong,nonatomic)HomeViewController*hmeVCtrl;
@property(strong,nonatomic)forgetViewController*forgetVCtrl;
- (IBAction)loginbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UIButton *forgetbtn;
-(IBAction)toforgetaction:(id)sender;
- (IBAction)lctnbtn:(id)sender;

@end

//
//  EqothersViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 6/9/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EqothersViewController : UIViewController
- (IBAction)clsebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UITableView *eqtable;
@property (strong, nonatomic) IBOutlet UITableViewCell *eqcell;
@property (strong, nonatomic) IBOutlet UIView *titleview;

@end

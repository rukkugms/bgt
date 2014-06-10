//
//  LabourViewController.h
//  Newproject
//
//  Created by GMSIndia 2 on 09/06/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lburmdl.h"

@interface LabourViewController : UIViewController
{
    BOOL recordResults;
    NSInteger sum;
}
@property(strong,nonatomic)Lburmdl *lbrmdl;

@property(strong,nonatomic)IBOutlet UIView *titleview;
@property(strong,nonatomic)IBOutlet UITableViewCell *labrcell;
@property(strong,nonatomic)IBOutlet UITableView *labrtable;
@property(strong,nonatomic)IBOutlet UILabel *totalquantitylabel;

/*cell Labels*/
@property(strong,nonatomic)IBOutlet UILabel *joblbl;
@property(strong,nonatomic)IBOutlet UILabel *itemcodelbl;
@property(strong,nonatomic)IBOutlet UILabel *deslbl;
@property(strong,nonatomic)IBOutlet UILabel *datelbl;
@property(strong,nonatomic)IBOutlet UILabel *quantitylbl;


/* xmlparser*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;


@property(strong,nonatomic)NSMutableArray *labourarray;
@property(strong,nonatomic)NSMutableArray *totalarray;

- (IBAction)clsebtn:(id)sender;
@end
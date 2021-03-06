//
//  NewrecordViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 2/19/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
#import "DrawingViewController.h"
#import "Validation.h"
@protocol newrecordDelgate <NSObject>

-(void)toreloadatable;

@end


@interface NewrecordViewController : UIViewController<updateDelgate>{
    BOOL recordResults;
    NSString *jobtypeitm;
    NSInteger istr;
    NSString *result;
    
    
  //  id <newrecordDelgate>Delegate;
}
@property(strong,nonatomic)NSString*curntdatestrg;
@property(strong,nonatomic)Validation *val;
@property(readwrite)NSInteger tabtype;
@property(readwrite)NSInteger reloadtype;
@property(nonatomic, strong)DrawingViewController *drwVCtrl;
@property(nonatomic, weak)id<newrecordDelgate>delegate;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(strong,nonatomic)IBOutlet UIView *view1;
@property(strong,nonatomic)IBOutlet UIView *view2;
@property(strong,nonatomic)IBOutlet UIView *view3;
/*popover*/
@property(strong,nonatomic)UIPopoverController *popOverController;
@property(strong,nonatomic)UITableView *popOverTableView;


@property(strong,nonatomic) NSString *companyid;
@property(strong,nonatomic) NSString *datesstrg;

/* xmlparser*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;

/*Product Rate*/


@property (strong, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)clsebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *ratetxtfld;
@property (strong, nonatomic) IBOutlet UITextField *descptntxtfld;
@property (strong, nonatomic) IBOutlet UITextField *valuetxtfld;
- (IBAction)updatepratebtn:(id)sender;
- (IBAction)pratecancel:(id)sender;

/*jobsite requirmnt*/
@property (strong, nonatomic)NSMutableDictionary * JobtypeDic;

@property (strong, nonatomic) IBOutlet UITextField *jobnametxtfld;
@property (strong, nonatomic) IBOutlet UITextField *jobcodetxtfld;
@property (strong, nonatomic) IBOutlet UIButton *typeidbtnlbl;

@property (strong, nonatomic) IBOutlet UITextField *jobcosttxtfld;
- (IBAction)typeidbtn:(id)sender;

- (IBAction)jobupdatebtn:(id)sender;

- (IBAction)cancelbtn:(id)sender;


/*Safty rules */
@property (strong, nonatomic) IBOutlet UITextField *ruletxtfld;

@property (strong, nonatomic) IBOutlet UITextField *ruldescptn;

- (IBAction)ruleupdte:(id)sender;
- (IBAction)rulecancel:(id)sender;

/*Equpment */
@property (strong, nonatomic) IBOutlet UITextField *equpnotxtfld;
@property (strong, nonatomic) IBOutlet UITextField *equpdscptn;

@property (strong, nonatomic) IBOutlet UITextField *equpareatxtfld;
@property (strong, nonatomic) IBOutlet UITextField *equnittxtfld;

- (IBAction)equupdtebtn:(id)sender;
- (IBAction)equcancelbtn:(id)sender;


/*wrkschedule*/
- (IBAction)startdatebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *startdatebtnlbl;
- (IBAction)enddatebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *enddatebtnlbl;
@property (strong, nonatomic) IBOutlet UITextField *wrkdesctxtfld;

- (IBAction)wrkupdtebtn:(id)sender;

- (IBAction)wrkschdlecancel:(id)sender;

/*meetingnotes*/

@property (strong, nonatomic) IBOutlet UIButton *datebtnlbl;

- (IBAction)datebtn:(id)sender;
//@property (strong, nonatomic) IBOutlet UITextField *meetgdetailslbl;
@property (strong, nonatomic) IBOutlet UITextView *meetgdetailslbl;

- (IBAction)meetgupdatebt:(id)sender;
- (IBAction)meetgcancelbtn:(id)sender;

/*otherbidders*/
@property (strong, nonatomic) IBOutlet UITextField *bidnamelbl;

- (IBAction)bidupdatebtn:(id)sender;
- (IBAction)bidcancelbtn:(id)sender;

/*weather outlook*/
@property (strong, nonatomic) IBOutlet UIButton *wethrfrmdatebtnlbl;
@property (strong, nonatomic) IBOutlet UIButton *wethrendbtnlbl;
@property (strong, nonatomic) IBOutlet UITextField *wathrcndtnlbl;

- (IBAction)wetherfrmbtn:(id)sender;
- (IBAction)weathrtodatebtn:(id)sender;
- (IBAction)wethrupdatebtn:(id)sender;

- (IBAction)weathrcancelbtn:(id)sender;
/*Notes*/
@property (strong, nonatomic) IBOutlet UIButton *notedatebtnlbl;
- (IBAction)notedatebtn:(id)sender;
//@property (strong, nonatomic) IBOutlet UITextField *notestxtfld;
@property (strong, nonatomic) IBOutlet UITextView *notestxtfld;

- (IBAction)notesupdatebtn:(id)sender;
- (IBAction)notescancelbtn:(id)sender;
- (IBAction)drawactn:(id)sender;
- (IBAction)drawnotesactn:(id)sender;
-(void) updatingtables;


@property(strong,nonatomic)NSString *displaydate;
@property(strong,nonatomic)NSString *displaynote;
@property(readwrite)NSInteger viewtype;

@property(strong,nonatomic)NSString *datendtime;
@property(strong,nonatomic)NSString *details;

@property(strong,nonatomic)IBOutlet UIButton *updatebtnnote;
@property(strong,nonatomic)IBOutlet UIButton *cancelnotebtn;
@property(strong,nonatomic)IBOutlet UIButton *drawnotebtn;
@property(strong,nonatomic)IBOutlet UIButton *updatemmeetingbtn;
@property(strong,nonatomic)IBOutlet UIButton *cancelmeetingnote;
@property(strong,nonatomic)IBOutlet UIButton *drawmeetingbtn;
@end

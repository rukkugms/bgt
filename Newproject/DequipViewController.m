//
//  DequipViewController.m
//  Newproject
//
//  Created by GMSIndia 2 on 23/04/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import "DequipViewController.h"
#define kCellHeight 44
#define kNavBarHeight 30

@interface DequipViewController ()

@end

@implementation DequipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    self.equiptouchview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
   _equipsrctitleview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
   _equipdesttitleview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    self.equipeditview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    
    // Do any additional setup after loading the view from its nib.
    self.equipsourcetable.layer.borderWidth=3.0;
    self.equipsourcetable.layer.borderColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor;
    self.equipdesttable.layer.borderWidth=3.0;
    self.equipdesttable.layer.borderColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor;
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanning:)];
    panGesture.delegate=self;
    [self.equiptouchview addGestureRecognizer:panGesture];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self equipsetupSourceTableWithFrame:CGRectMake(0, 0, 266,610)];
    [self equipsetupDestinationTableWithFrame:CGRectMake(0, 0, 682, 533)];
    
    [self SelectAllEquipment];
    [self GeneralResourceDetailselect];
}

- (IBAction)clsbtn:(id)sender {
}
- (IBAction)closeequip:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)deleteequip:(id)sender
{
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_equipdesttable setEditing:NO animated:NO];
        [_equipdesttable reloadData];
        
        
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_equipdesttable setEditing:YES animated:YES];
        [_equipdesttable reloadData];
        
        
    }
    
}
- (IBAction)editequip:(id)sender
{
    _equipeditview.hidden=NO;
    equipbtn = (UIButton *)sender;
    CGPoint center= equipbtn.center;
    CGPoint rootViewPoint = [equipbtn.superview convertPoint:center toView:self.equipdesttable];
    NSIndexPath *textFieldIndexPath = [self.equipdesttable indexPathForRowAtPoint:rootViewPoint];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    btnindex=textFieldIndexPath.row;
    
    Drageqmodel*dmodel=(Drageqmodel *)[_equipdestarray objectAtIndex:btnindex];
    _equipitemcodetextfield.text=dmodel.eqitemcode;
    _equipitemdesctextfield.text=dmodel.eqdesc;
    _equipqtytextfield.text=dmodel.qty;
   
    if (dmodel.hrate==0) {
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        
    }
    else if(dmodel.hrate==1){
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        
    }
    if (dmodel.drate==0) {
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        
    }
    else if(dmodel.drate==1){
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        
    }
    if (dmodel.wrate==0) {
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        
    }
    else if(dmodel.wrate==1){
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        
    }
    if (dmodel.mrate==0) {
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        
    }
    else if(dmodel.mrate==1){
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        
    }

    _hratecheck=@"";
    _mratecheck=@"";
    _wratecheck=@"";
    _dratecheck=@"";
    
}
- (IBAction)closeequipeditview:(id)sender
{
    _equipeditview.hidden=YES;
}
- (IBAction)updateequip:(id)sender
{
    [self GeneralResourceDetailUpdate];
}
- (IBAction)hratecheckaction:(id)sender
{
    _hratecheck=@"h";
    if (hcheck==0) {
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        hcheck=1;
        dcheck=0;
        wcheck=0;
        mcheck=0;
        
    }
    
    else{
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        hcheck=0;
        
    }
    
}
-(IBAction)dratecheckaction:(id)sender
{
    _dratecheck=@"d";
    if (dcheck==0) {
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        dcheck=1;
        hcheck=0;
        wcheck=0;
        mcheck=0;
        
    }
    
    else{
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        dcheck=0;
        
    }
    
}
-(IBAction)wratecheckaction:(id)sender
{
    _wratecheck=@"w";
    if (wcheck==0) {
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        wcheck=1;
        dcheck=0;
        hcheck=0;
        mcheck=0;
        
    }
    
    else{
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        wcheck=0;
        
    }
    
}
-(IBAction)mratecheckaction:(id)sender
{
    _mratecheck=@"m";
    if (mcheck==0) {
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        mcheck=1;
        dcheck=0;
        wcheck=0;
        hcheck=0;
        
    }
    
    else{
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        mcheck=0;
        
    }
    
}
#pragma mark-tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_equipsourcetable) {
        return [_equipsrcarray count];
        
        
    }
    if (tableView==_equipdesttable) {
        
        return [_equipdestarray count];
        
    }
    return YES;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if (tableView==_equipsourcetable) {
            [[NSBundle mainBundle]loadNibNamed:@"Srcequcell" owner:self options:nil];
            cell=_equipsourcecell;
            
        }
        if (tableView==_equipdesttable) {
            [[NSBundle mainBundle]loadNibNamed:@"Destequcell" owner:self options:nil];
            
            cell=_equipdestcell;
        }
        
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
        
    }
    if (tableView==_equipsourcetable) {
        //cell.textLabel.text=[srcData objectAtIndex:indexPath.row];
        
        Equpmntmdl *emdl=(Equpmntmdl *)[_equipsrcarray objectAtIndex:indexPath.row];
        
        _equipitemlabel=(UILabel *)[cell viewWithTag:1];
        _equipitemlabel.text=emdl.itemcode;
        _equideslabel=(UILabel *)[cell viewWithTag:2];
        _equideslabel.text=emdl.itemdescptn;
        
        
    }
    if (tableView==_equipdesttable) {
        
        Drageqmodel *dmodel=(Drageqmodel *)[_equipdestarray objectAtIndex:indexPath.row];
        
        _equipitemdestlabel=(UILabel *)[cell viewWithTag:1];
        _equipitemdestlabel.text=dmodel.eqitemcode;
        _equipdescdestlabel=(UILabel *)[cell viewWithTag:2];
        _equipdescdestlabel.text=dmodel.eqdesc;
        _equipquantdestlabel=(UILabel *)[cell viewWithTag:3];
        _equipquantdestlabel.text=dmodel.qty;
//        _equiphratedestlabel=(UILabel *)[cell viewWithTag:4];
//        _equiphratedestlabel.text=dmodel.hrate;
//        _equipdratedestlabel=(UILabel *)[cell viewWithTag:5];
//        _equipdratedestlabel.text=dmodel.drate;
//        _equipwratedestlabel=(UILabel *)[cell viewWithTag:6];
//        _equipwratedestlabel.text=dmodel.wrate;
//        _equipmratedestlabel=(UILabel *)[cell viewWithTag:7];
//        _equipmratedestlabel.text=dmodel.mrate;
//        NSInteger h1=[dmodel.hrate integerValue];
//        NSInteger d1=[dmodel.drate integerValue];
//        NSInteger w1=[dmodel.wrate integerValue];
//        NSInteger m1=[dmodel.mrate integerValue];
        if (dmodel.hrate ==0) {
            [_hratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
            
        }
        else if(dmodel.hrate ==1){
            [_hratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
            
        }
        if (dmodel.drate==0) {
            [_dratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
            
        }
        else if(dmodel.drate==1){
            [_dratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
            
        }
        if (dmodel.wrate==0) {
            [_wratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
            
        }
        else if(dmodel.wrate==1){
            [_wratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
            
        }
        if (dmodel.mrate==0) {
            [_mratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
            
        }
        else if(dmodel.mrate==1){
            [_mratecellcheckbutton setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
            
        }
        
        
        
        
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        eqdeletepath=indexPath.row;
        
        if (tableView==_equipdesttable) {
            [self GeneralResourceDetailDelete];
            [_equipdestarray removeObject:indexPath];
            
        }
        
    }
}
#pragma mark-webservices

-(void)SelectAllEquipment{
    recordResults = FALSE;
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<PlanEquipmentSelect xmlns=\"http://ios.kontract360.com/\">\n"
                   
                   "</PlanEquipmentSelect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //NSURL *url = [NSURL URLWithString:@"http://192.168.0.125/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://ios.kontract360.com/PlanEquipmentSelect" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)GeneralResourceDetailselect{
    recordResults = FALSE;
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GeneralResourceDetailselect xmlns=\"http://ios.kontract360.com/\">\n"
                   "<MainGeneralId>%d</MainGeneralId>"
                   "</GeneralResourceDetailselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[_generalid integerValue]];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //NSURL *url = [NSURL URLWithString:@"http://192.168.0.125/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://ios.kontract360.com/GeneralResourceDetailselect" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)GeneralResourceDetailInsert{
    webtype=1;
    recordResults = FALSE;
    NSString *soapMessage;
    Equpmntmdl *emodel=(Equpmntmdl *)[_equipsrcarray objectAtIndex:equippath];
    NSString *etype=@"EQ";
    NSString *ename=@"Equipments";
    NSString *quantity=@"1";
    NSInteger hrate=0;
    NSInteger drate=0;
    NSInteger wrate=0;
    NSInteger mrate=0;
    NSInteger yrate=0;
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GeneralResourceDetailInsert xmlns=\"http://ios.kontract360.com/\">\n"
                   "<MainGeneralId>%d</MainGeneralId>\n"
                   "<SubGeneralResourceId>%d</SubGeneralResourceId>\n"
                   "<ManPower>%@</ManPower>\n"
                   "<Description>%@</Description>\n"
                   "<Type>%@</Type>\n"
                   "<Name>%@</Name>\n"
                   "<Qty>%d</Qty>\n"
                   "<HourlyRate>%d</HourlyRate>\n"
                   "<DailyRate>%d</DailyRate>\n"
                   "<WeeklyRate>%d</WeeklyRate>\n"
                   "<MonthlyRate>%d</MonthlyRate>\n"
                   "<YearlyRate>%d</YearlyRate>\n"
                   "</GeneralResourceDetailInsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[_generalid integerValue],emodel.entryid,emodel.itemcode,emodel.itemdescptn,etype,ename,[quantity integerValue],hrate,drate,wrate,mrate,yrate];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.125/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://ios.kontract360.com/GeneralResourceDetailInsert" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)GeneralResourceDetailUpdate{
    webtype=1;
    recordResults = FALSE;
    NSString *soapMessage;
    Drageqmodel *dmodel=(Drageqmodel *)[_equipdestarray objectAtIndex:btnindex];
    NSString *etype=@"EQ";
    NSString *ename=@"Equipments";
    NSString *quantity=_equipqtytextfield.text;
    NSInteger hrate;
    NSInteger drate;
    NSInteger wrate;
    NSInteger mrate;
    NSInteger yrate;
    yrate=0;
    NSLog(@"%@",_hratecheck);
    if([_hratecheck isEqualToString:@""]&&[_dratecheck isEqualToString:@""]&&[_mratecheck isEqualToString:@""]&&[_wratecheck isEqualToString:@""])
    {
        mrate=dmodel.mrate;
        drate=dmodel.drate;
        wrate=dmodel.wrate;
        hrate=dmodel.hrate;
    }
    else
    {

//    if([_hratecheck isEqualToString:@"h"])
//    {
        if (hcheck==0) {
            hrate=0;
        }
        else{
            hrate=1;
            drate=0;
            wrate=0;
            mrate=0;
        }
//        _hratecheck=@"";
//    }
//    else
//    {
//        hrate=dmodel.hrate;
//    }
    
//    if([_dratecheck isEqualToString:@"d"])
//   {
        if (dcheck==0) {
            drate=0;
        }
        else{
            drate=1;
            mrate=0;
            wrate=0;
            hrate=0;
            
        }
//        _dratecheck=@"";
//    }
//    else
//    {
//        drate=dmodel.drate;
//    }
    
    
    if([_wratecheck isEqualToString:@"w"])
    {
        if (wcheck==0) {
            
            wrate=0;
        }
        else{
            wrate=1;
            drate=0;
            hrate=0;
            mrate=0;
            
        }
//        _wratecheck=@"";
   }
//    else
//    {
//        wrate=dmodel.wrate;
//    }
    
    
//   if([_mratecheck isEqualToString:@"m"])    {
        if (mcheck==0) {
            mrate=0;
        }
        else{
            mrate=1;
            drate=0;
            wrate=0;
            hrate=0;
            
//        }
//        _mratecheck=@"";
}
    
//    else
//    {
//        mrate=dmodel.mrate;
//    }
    }
      soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GeneralResourceDetailUpdate xmlns=\"http://ios.kontract360.com/\">\n"
                   "<Id>%d</Id>\n"
                   "<MainGeneralId>%d</MainGeneralId>\n"
                   "<SubGeneralResourceId>%d</SubGeneralResourceId>\n"
                   "<ManPower>%@</ManPower>\n"
                   "<Description>%@</Description>\n"
                   "<Type>%@</Type>\n"
                   "<Name>%@</Name>\n"
                   "<Qty>%d</Qty>\n"
                   "<HourlyRate>%d</HourlyRate>\n"
                   "<DailyRate>%d</DailyRate>\n"
                   "<WeeklyRate>%d</WeeklyRate>\n"
                   "<MonthlyRate>%d</MonthlyRate>\n"
                   "<YearlyRate>%d</YearlyRate>\n"
                   "</GeneralResourceDetailUpdate>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",dmodel.idvalue,dmodel.mainGeneralId,dmodel.SubGeneralResourceId,dmodel.eqitemcode,dmodel.eqdesc,etype,ename,[quantity integerValue],hrate,drate,wrate ,mrate ,yrate];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.125/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://ios.kontract360.com/GeneralResourceDetailUpdate" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}

-(void)GeneralResourceDetailDelete{
    webtype=2;
    recordResults = FALSE;
    NSString *soapMessage;
    
    Drageqmodel *dmodel=(Drageqmodel *)[_equipdestarray objectAtIndex:eqdeletepath];
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GeneralResourceDetailDelete xmlns=\"http://ios.kontract360.com/\">\n"
                   "<Id>%d</Id>\n"
                   "</GeneralResourceDetailDelete>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",dmodel.idvalue];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://ios.kontract360.com/GeneralResourceDetailDelete" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}



#pragma mark - Connection
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[_webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   	[_webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *  Alert=[[UIAlertView alloc]initWithTitle:nil message:@"ERROR with the Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [Alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %d", [_webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"xml===== %@",theXML);
	
	
	if( _xmlParser )
	{
		
	}
	
	_xmlParser = [[NSXMLParser alloc] initWithData: _webData];
	[_xmlParser setDelegate:(id)self];
	[_xmlParser setShouldResolveExternalEntities: YES];
	[_xmlParser parse];
    [_equipsourcetable reloadData];
    [_equipdesttable reloadData];
    if (webtype==1||webtype==2) {
        [self GeneralResourceDetailselect];
        webtype=0;
    }
    
    
}

#pragma mark-xml parser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    
    
    if([elementName isEqualToString:@"PlanEquipmentSelectResponse"])
    {
        _equipsrcarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"GeneralEntryId"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"GeneralDescription"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"GeneralItemCode"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"GeneralResourceDetailselectResponse"])
    {
        _equipdestarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"mainGeneralId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"SubGeneralResourceId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"EqItemCode"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Description"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Type"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Qty"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"HourlyRate"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"DailyRate"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"WeeklyRate"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"MonthlyRate"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
        if([elementName isEqualToString:@"GeneralResourceDetailUpdateResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"GeneralResourceDetailInsertResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"result"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    
    
    
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    
	if( recordResults )
        
	{
        [_soapResults appendString: string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"GeneralEntryId"])
    {
        
        _eqmdl=[[Equpmntmdl alloc]init];
        recordResults = FALSE;
        
        _eqmdl.entryid=[_soapResults integerValue];
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"GeneralDescription"])
    {
        
        recordResults = FALSE;
        _eqmdl.itemdescptn=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"GeneralItemCode"])
    {
        
        recordResults = FALSE;
        _eqmdl.itemcode=_soapResults;
        [_equipsrcarray addObject:_eqmdl];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Id"])
    {
        
        _dmdl=[[Drageqmodel alloc]init];
        recordResults = FALSE;
        
        _dmdl.idvalue=[_soapResults integerValue];
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"mainGeneralId"])
    {
        
        
        recordResults = FALSE;
        
        _dmdl.mainGeneralId=[_soapResults integerValue];
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"SubGeneralResourceId"])
    {
        
        
        recordResults = FALSE;
        
        _dmdl.SubGeneralResourceId=[_soapResults integerValue];
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"EqItemCode"])
    {
        
        
        recordResults = FALSE;
        
        _dmdl.eqitemcode=_soapResults;
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"Description"])
    {
        
        
        recordResults = FALSE;
        
        _dmdl.eqdesc=_soapResults;
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"Type"])
    {
        
        
        recordResults = FALSE;
        
        _dmdl.eqtype=_soapResults;
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"Name"])
    {
        
        
        recordResults = FALSE;
        
        _dmdl.ename=_soapResults;
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"Qty"])
    {
        
        
        recordResults = FALSE;
        
        _dmdl.qty=_soapResults;
        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"HourlyRate"])
    {
        
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"false"]) {
            _dmdl.hrate=0;
            //checkbtnclick=0;
            
        }
        else{
            _dmdl.hrate=1;
            //checkbtnclick=1;
        }

        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"DailyRate"])
    {
        
        
        recordResults = FALSE;
        
        
        if ([_soapResults isEqualToString:@"false"]) {
            _dmdl.drate=0;
            //checkbtnclick=0;
            
        }
        else{
            _dmdl.drate=1;
            //checkbtnclick=1;
        }
        
        _soapResults = nil;    }
    
    if([elementName isEqualToString:@"WeeklyRate"])
    {
        
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"false"]) {
            _dmdl.wrate=0;
            //checkbtnclick=0;
            
        }
        else{
            _dmdl.wrate=1;
            //checkbtnclick=1;
        }

        
        _soapResults = nil;    }
    if([elementName isEqualToString:@"MonthlyRate"])
    {
        
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"false"]) {
            _dmdl.mrate=0;
            //checkbtnclick=0;
            
        }
        else{
            _dmdl.mrate=1;
            //checkbtnclick=1;
        }

        [_equipdestarray addObject:_dmdl];
        
        _soapResults = nil;    }
//    
//    if([elementName isEqualToString:@"YearlyRate"])
//    {
//        
//        
//        recordResults = FALSE;
//        
//        _dmdl.yrate=_soapResults;
//        [_equipdestarray addObject:_dmdl];
//        _soapResults = nil;
//    }
    if([elementName isEqualToString:@"result"])
    {
        
        
        recordResults = FALSE;
        _result=_soapResults;
        if (webtype==1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:_result delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
        _soapResults = nil;
    }
    
    
    
}
#pragma mark-Alertview Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertView.message isEqualToString:_result]) {
        dcheck=0;
        mcheck=0;
        hcheck=0;
        wcheck=0;
        [_hratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_mratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_dratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        [_wratecheckbutton setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        _equipitemcodetextfield.text=@"";
        _equipitemdesctextfield.text=@"";
        _equipqtytextfield.text=@"";
        
    }
    
    
}

#pragma mark UIGestureRecognizer

- (void)handlePanning:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan:
            [self equipstartDragging:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self doDrag:gestureRecognizer];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self equipstopDragging:gestureRecognizer];
            break;
        default:
            break;
    }
}
#pragma mark Helper methods for dragging
- (void)equipstartDragging:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint pointInSrc = [gestureRecognizer locationInView:_equipsourcetable];
    CGPoint pointInDst = [gestureRecognizer locationInView:_equipdesttable];
    
    if([_equipsourcetable pointInside:pointInSrc withEvent:nil])
    {
        [self equipstartDraggingFromSrcAtPoint:pointInSrc];
        equipdragFromSource = YES;
    }
    else if([_equipdesttable pointInside:pointInDst withEvent:nil])
    {
        //[self equipstartDraggingFromDstAtPoint:pointInDst];
        equipdragFromSource = NO;
    }
}

- (void)equipstartDraggingFromSrcAtPoint:(CGPoint)point
{
    NSIndexPath* indexPath = [_equipsourcetable indexPathForRowAtPoint:point];
    UITableViewCell* cell = [_equipsourcetable cellForRowAtIndexPath:indexPath];
    
    if(cell != nil)
    {
        CGPoint origin = cell.frame.origin;
        origin.x += _equipsourcetable.frame.origin.x;
        origin.y += _equipsourcetable.frame.origin.y;
        
        [self equipinitDraggedCellWithCell:cell AtPoint:origin];
        cell.highlighted = NO;
        
        if(equipdraggedData != nil)
        {
            //[draggedData release];
            equipdraggedData = nil;
        }
        
        equippath=indexPath.row;
        
        Equpmntmdl *emdl=(Equpmntmdl *)[_equipsrcarray objectAtIndex:equippath];
        
        equipdraggedData = emdl.itemcode;
        NSLog(@"name2%@",emdl.itemcode);
        NSLog(@"apath%d",equippath);
    }
}
- (void)doDrag:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(equipdraggedCell != nil && equipdraggedData != nil)
    {
        CGPoint translation = [gestureRecognizer translationInView:[equipdraggedCell superview]];
        [equipdraggedCell setCenter:CGPointMake([equipdraggedCell center].x + translation.x,
                                                [equipdraggedCell center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[equipdraggedCell superview]];
    }
}
- (void)equipstopDragging:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(equipdraggedCell != nil && equipdraggedData != nil)
    {
        
        //NSLog(@"%d",[gestureRecognizer state]);
        //NSLog(@"%hhd",[dropArea pointInside:[gestureRecognizer locationInView:dropArea] withEvent:nil]);
        
        
        if([gestureRecognizer state] == UIGestureRecognizerStateEnded
           && [equipdropArea pointInside:[gestureRecognizer locationInView:equipdropArea] withEvent:nil])
        {
            NSIndexPath* indexPath = [_equipdesttable indexPathForRowAtPoint:[gestureRecognizer locationInView:_equipdesttable]];
            if(indexPath != nil)
            {
                Drageqmodel *dmdl=(Drageqmodel *)[_equipdestarray objectAtIndex:indexPath.row];
                dmdl.eqitemcode=equipdraggedData;
                [_equipdestarray addObject:dmdl];

                //[_equipdestarray insertObject:equipdraggedData atIndex:indexPath.row];
                [_equipdesttable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            }
            else
            {
                if ([_equipdestarray count]==0) {
                    Drageqmodel *dmdl=[[Drageqmodel alloc]init];
                    dmdl.eqitemcode=equipdraggedData;
                    [_equipdestarray addObject:dmdl];

                }
                else
                {
                
                Drageqmodel *dmdl=(Drageqmodel *)[_equipdestarray objectAtIndex:indexPath.row];
                dmdl.eqitemcode=equipdraggedData;
                [_equipdestarray addObject:dmdl];
                }
                
                [self GeneralResourceDetailInsert];
            }
        }
        else if(!equipdragFromSource && equippathFromDstTable != nil)
        {
            // insert cell back where it came from
            [_equipdestarray insertObject:equipdraggedData atIndex:equippathFromDstTable.row];
            [_equipdesttable insertRowsAtIndexPaths:[NSArray arrayWithObject:equippathFromDstTable] withRowAnimation:UITableViewRowAnimationMiddle];
            
            //[pathFromDstTable release];
            equippathFromDstTable = nil;
        }
        
        [UIView animateWithDuration:0.3 animations:^
         {
             CGRect frame = _equipdesttable.frame;
             //frame.size.height = kCellHeight * [_Maintablescflddetailsarray count];
             _equipdesttable.frame = frame;
         }];
        
        [equipdraggedCell removeFromSuperview];
        //[draggedCell release];
        equipdraggedCell = nil;
        
        //[draggedData release];
        equipdraggedData = nil;
    }
}
- (void)startDraggingFromDstAtPoint:(CGPoint)point
{
    NSIndexPath* indexPath = [_equipdesttable indexPathForRowAtPoint:point];
    UITableViewCell* cell = [_equipdesttable cellForRowAtIndexPath:indexPath];
    if(cell != nil)
    {
        CGPoint origin = cell.frame.origin;
        origin.x += equipdropArea.frame.origin.x;
        origin.y += equipdropArea.frame.origin.y;
        
        [self equipinitDraggedCellWithCell:cell AtPoint:origin];
        cell.highlighted = NO;
        
        if(equipdraggedData != nil)
        {
            //[draggedData release];
            equipdraggedData = nil;
        }
        Equpmntmdl*emdl=(Equpmntmdl *)[_equipsrcarray objectAtIndex:indexPath.row];
        equipdraggedData = emdl.itemcode;
        
        // remove old cell
        [_equipdestarray removeObjectAtIndex:indexPath.row];
        [_equipdesttable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        equippathFromDstTable = indexPath;
        
        [UIView animateWithDuration:0.2 animations:^
         {
             CGRect frame = _equipdesttable.frame;
             //frame.size.height = kCellHeight * [dstData count];
             _equipdesttable.frame = frame;
         }];
        
    }
}



#pragma mark Helper methods for initialization

- (void)equipsetupSourceTableWithFrame:(CGRect)frame
{
    
    [self.equiptouchview addSubview:_equipsourcetable];
}

- (void)equipsetupDestinationTableWithFrame:(CGRect)frame
{
    
    CGRect equipdropAreaFrame = frame;
    equipdropAreaFrame.origin.y = kNavBarHeight;
    equipdropAreaFrame.size.height -= kNavBarHeight;
    
    equipdropArea = [[UIView alloc] initWithFrame:CGRectMake(305, 35, 688, 700)];
    [equipdropArea setBackgroundColor:[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f]];
    [self.equiptouchview addSubview:equipdropArea];
    
    CGRect contentFrame = equipdropAreaFrame;
    contentFrame.origin = CGPointMake(0, 0);
    
    UILabel* equipdropAreaLabel = [[UILabel alloc] initWithFrame:contentFrame];
    equipdropAreaLabel.backgroundColor = [UIColor clearColor];
    equipdropAreaLabel.font = [UIFont boldSystemFontOfSize:12];
    equipdropAreaLabel.textAlignment = NSTextAlignmentCenter;
    equipdropAreaLabel.textColor = [UIColor whiteColor];
    // dropAreaLabel.text = @"Drop items here...";
    [equipdropArea addSubview:equipdropAreaLabel];
    
    [equipdropArea addSubview:_equipdesttable];
}
- (void)equipinitDraggedCellWithCell:(UITableViewCell*)cell AtPoint:(CGPoint)point
{
    NSIndexPath* indexPath = [_equipsourcetable indexPathForRowAtPoint:point];
    NSLog(@"name1%d",indexPath.row);
    //UITableViewCell* cell = [_subtypetable cellForRowAtIndexPath:indexPath];
    // get rid of old cell, if it wasn't disposed already
    if(equipdraggedCell != nil)
    {
        [equipdraggedCell removeFromSuperview];
        // [draggedCell release];
        equipdraggedCell = nil;
    }
    
    CGRect frame = CGRectMake(point.x, point.y, cell.frame.size.width-5, cell.frame.size.height-10);
    
    equipdraggedCell = [[UITableViewCell alloc] init];
    equipdraggedCell.selectionStyle = UITableViewCellSelectionStyleGray;
    Equpmntmdl *emdl=(Equpmntmdl *)[_equipsrcarray objectAtIndex:indexPath.row];
    equipdraggedCell.textLabel.text =emdl.itemcode;
    NSLog(@"name1%@",emdl.itemcode);
    NSLog(@"apath%d",indexPath.row);
    equipdraggedCell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
    
    equipdraggedCell.textLabel.textColor = cell.textLabel.textColor;
    equipdraggedCell.highlighted = YES;
    equipdraggedCell.frame = frame;
    equipdraggedCell.alpha = 0.8;
    
    [self.equiptouchview addSubview:equipdraggedCell];
}







@end



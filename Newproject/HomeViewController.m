//
//  HomeViewController.m
//  Newproject
//
//  Created by GMSIndia1 on 6/14/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    // Do any additional setup after loading the view from its nib.
    /*new comment*/
    
}
-(IBAction)logout:(id)sender
{   _ModuleID=0;
    _result=@"";
   
    [self Logoutselect];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _result=@"";
//    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"logout1"] style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];
//    
//    // [self.navigationItem setRightBarButtonItem:logoutbutton animated:YES];
//    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton, nil];
//    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(customerpage)];
    doubleTap.numberOfTapsRequired=1;
    doubleTap.delegate=(id)self;
    [self.customerview addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *doubleTap1 = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(LeadPage)];
    doubleTap1.numberOfTapsRequired=1;
    doubleTap1.delegate=(id)self;
    [self.leadView addGestureRecognizer:doubleTap1];
    UITapGestureRecognizer *doubleTap2 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(companyPage)];
    doubleTap2.numberOfTapsRequired=1;
    doubleTap2.delegate=(id)self;
    [self.companyView addGestureRecognizer:doubleTap2];

    
    UITapGestureRecognizer *doubleTap3 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(hrpage)];
    doubleTap3.numberOfTapsRequired=1;
    doubleTap3.delegate=(id)self;
    [self.hrview addGestureRecognizer:doubleTap3];
    
    UITapGestureRecognizer *doubleTap4 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(repage)];
    doubleTap4.numberOfTapsRequired=1;
    doubleTap4.delegate=(id)self;
    [self.reurceview addGestureRecognizer:doubleTap4];
    
    UITapGestureRecognizer *doubleTap5 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(plangpage)];
    doubleTap5.numberOfTapsRequired=1;
    doubleTap5.delegate=(id)self;
    [self.planngview addGestureRecognizer:doubleTap5];
    UITapGestureRecognizer *doubleTap6 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(Estimationpage)];
    doubleTap6.numberOfTapsRequired=1;
    doubleTap6.delegate=(id)self;
    [self.estimtnview addGestureRecognizer:doubleTap6];

    UITapGestureRecognizer *doubleTap7 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(Managementpage)];
    doubleTap7.numberOfTapsRequired=1;
    doubleTap7.delegate=(id)self;
    [self.projectview addGestureRecognizer:doubleTap7];

}

#pragma mark- WebService
-(void)Logoutselect{
    recordResults = FALSE;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<Logoutselect xmlns=\"http://testUSA.kontract360.com/\">\n"
                   "<UserName>%@</UserName>\n"
                   "<LogOutTime>%@</LogOutTime>\n"
                   "</Logoutselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_username,curntdate];
    NSLog(@"soapmsg%@",soapMessage);
    
    
   // NSURL *url = [NSURL URLWithString:@"http://testusa.kontract360.com/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://testusa.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://testUSA.kontract360.com/Logoutselect" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)UserRightsforparticularmoduleselect{
    recordResults = FALSE;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    userid = [defaults objectForKey:@"Userid"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserRightsforparticularmoduleselect xmlns=\"http://testUSA.kontract360.com/\">\n"
                   "<UserId>%d</UserId>\n"
                   "<ModuleId>%d</ModuleId>\n"
                   "</UserRightsforparticularmoduleselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[userid integerValue],_ModuleID];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://testusa.kontract360.com/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://testusa.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://testUSA.kontract360.com/UserRightsforparticularmoduleselect" forHTTPHeaderField:@"Soapaction"];
    
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
    //NSDictionary *dictionary=[_xmlParser dictionaryWithValuesForKeys:[[NSArray alloc]initWithObjects:@"JobNumber", nil]];
    
    //  NSLog(@"dictioanry is %@",dictionary);
    
    
	[_xmlParser parse];
    if ([_result isEqualToString:@"Not yet set"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Your rights are not yet set" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    
    else
    {
    if (_ModuleID==1) {
        
    Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
    if (rightsmodel.ViewModule==1) {
        
        
        if (!self.tileVCtrl) {
            self.tileVCtrl=[[TileViewController alloc]initWithNibName:@"TileViewController" bundle:nil];
        }
        _tileVCtrl.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:_tileVCtrl
                           animated:YES completion:NULL];
    }
    else
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        }
        //You don’t have right to view this form
    
    

    }
    if (_ModuleID==2) {
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        if (rightsmodel.ViewModule==1) {
            
            
            if (!self.ReVCtrl) {
                self.ReVCtrl=[[ResViewController alloc]initWithNibName:@"ResViewController" bundle:nil];
            }
            _ReVCtrl.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:_ReVCtrl
                               animated:YES completion:NULL];

        }
        else
        {
           
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    if (_ModuleID==3)
    {
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        if (rightsmodel.ViewModule==1) {
        if (!self.custmrVCtrl) {
            self.custmrVCtrl=[[TilecustmrViewController alloc]initWithNibName:@"TilecustmrViewController" bundle:nil];
        }
        _custmrVCtrl.modalPresentationStyle = UIModalPresentationFormSheet;
        
        
        [self presentViewController:_custmrVCtrl
                           animated:YES completion:NULL];
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    if (_ModuleID==4)
    {
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        if (rightsmodel.ViewModule==1) {
            if (!self.LCtrl) {
                self.LCtrl=[[TLLeadsViewController alloc]initWithNibName:@"TLLeadsViewController" bundle:nil];
            }
             _LCtrl.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:_LCtrl
                               animated:YES completion:NULL];
        }
        else
        {
           
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        
        }
    }
    if (_ModuleID==5)
    {
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        if (rightsmodel.ViewModule==1) {
            if (!self.PlnCtrl) {
                self.PlnCtrl=[[PlngTileViewController alloc]initWithNibName:@"PlngTileViewController" bundle:nil];
                
            }
            // _PlangVCtrl.view.frame=CGRectMake(100, 171, 768, 768);
             _PlnCtrl.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:_PlnCtrl
                               animated:YES completion:NULL];
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    if (_ModuleID==6)
    {
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        if (rightsmodel.ViewModule==1) {
            if (!self.EstmVCtrl) {
                self.EstmVCtrl=[[EsttileViewController alloc]initWithNibName:@"EsttileViewController" bundle:nil];
            }
            _EstmVCtrl.modalPresentationStyle=UIModalPresentationFormSheet;
            _EstmVCtrl.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
            [self presentViewController:_EstmVCtrl
                               animated:YES completion:NULL];

        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    if (_ModuleID==7)
    {
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        if (rightsmodel.ViewModule==1) {
            if (!_mangVCtrl) {
                _mangVCtrl=[[ManagemttileViewController alloc]initWithNibName:@"ManagemttileViewController" bundle:nil];
            }
            _mangVCtrl.modalPresentationStyle=UIModalPresentationFormSheet;
            _mangVCtrl.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
            [self presentViewController:_mangVCtrl
                               animated:YES completion:NULL];
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    if (_ModuleID==8)
    {
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        if (rightsmodel.ViewModule==1) {
            if (!self.TilehrVCtrl) {
                self.TilehrVCtrl=[[TilehrViewController alloc]initWithNibName:@"TilehrViewController" bundle:nil];
            }
            
            _TilehrVCtrl.modalPresentationStyle=UIModalPresentationFormSheet;
            
            [self presentViewController:_TilehrVCtrl
                               animated:YES completion:NULL];

        }
        else
        {
            

            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        
        }
    }
   

    }
    
}

#pragma mark-xml parser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"LogoutselectResponse"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"message"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
       if([elementName isEqualToString:@"UserRightsforparticularmoduleselectResponse"])
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


//    if([elementName isEqualToString:@"UserRightsforparticularmoduleselectResult"])
//    {
//        _userrightsarray=[[NSMutableArray alloc]init];
//        
//        if(!_soapResults)
//        {
//            _soapResults = [[NSMutableString alloc] init];
//        }
//        recordResults = TRUE;
//    }

    if([elementName isEqualToString:@"EntryId"])
    {
        _userrightsarray=[[NSMutableArray alloc]init];
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"UserId"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"ModuleId"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"ViewModule"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"EditModule"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"DeleteModule"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"PrintModule"])
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
    if([elementName isEqualToString:@"message"]){
        
        recordResults = FALSE;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        _soapResults=nil;
      }
    if([elementName isEqualToString:@"EntryId"])
    {
        
        
        recordResults = FALSE;
        _rights=[[Rightscheck alloc]init];
        _rights.entryid=[_soapResults integerValue];
        
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"result"])
    {
        
        
        recordResults = FALSE;
        
        _result=@"Not yet set";
//        if ([_soapResults isEqualToString:@"0"]) {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"You don’t have right to view this form" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
        
        _soapResults=nil;
    }

    if([elementName isEqualToString:@"UserId"])
    {
        
        
        recordResults = FALSE;
        
        _rights.userid=[_soapResults integerValue];
        
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"ModuleId"])
    {
        
        
        recordResults = FALSE;
        
        _rights.moduleid=[_soapResults integerValue];
        
        _soapResults=nil;

    }
    if([elementName isEqualToString:@"ViewModule"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.ViewModule=1;
            
            
        }
        else{
            _rights.ViewModule=0;
           
        }
        

        
        _soapResults=nil;

       
    }
    if([elementName isEqualToString:@"EditModule"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.EditModule=1;
            
            
        }
        else{
            _rights.EditModule=0;
            
        }
        _soapResults=nil;

       
    }
    if([elementName isEqualToString:@"DeleteModule"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.DeleteModule=1;
            
            
        }
        else{
            _rights.DeleteModule=0;
            
        }
        _soapResults=nil;
       
    }
    if([elementName isEqualToString:@"PrintModule"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _rights.PrintModule=1;
            
            
        }
        else{
            _rights.PrintModule=0;
            
        }

       
    
    [_userrightsarray addObject:_rights];
    _soapResults=nil;

}

}
-(void)customerpage{
   _ModuleID=3;
     [self UserRightsforparticularmoduleselect];
    
    
    
}
-(void)LeadPage
{
   _ModuleID=4;
     [self UserRightsforparticularmoduleselect];
   
    

}
-(void)companyPage
{
    _ModuleID=1;
    [self UserRightsforparticularmoduleselect];
    
}
-(void)hrpage{
   _ModuleID=8;
    [self UserRightsforparticularmoduleselect];
   
}
-(void)repage{
   _ModuleID=2;
    [self UserRightsforparticularmoduleselect];

    
    
}
-(void)plangpage{
   _ModuleID=5;
     [self UserRightsforparticularmoduleselect];
    

}
-(void)Estimationpage{
   _ModuleID=6;
     [self UserRightsforparticularmoduleselect];
    
    
}
-(void)Managementpage{
  _ModuleID=7;
     [self UserRightsforparticularmoduleselect];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

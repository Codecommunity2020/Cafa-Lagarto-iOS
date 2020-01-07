//
//  ViewController.m
//  CafeDemo
//
//  Created by iPHTech11 on 29/02/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import "ViewController.h"
#import "SlideNavigationController.h"
#import "LeftPanelViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize webView,titleOfController,urlStr;

NSNumber *freeCliamDone;





- (void)viewDidLoad {
    [super viewDidLoad];
    [webView setDelegate:self];
    indecator.center = self.view.center;
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLocating:) name:@"ForceUpdateLocation" object:nil];
//    
//    
   
    [self showAtAppearTime];
    }

-(void) viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [[GAI sharedInstance].defaultTracker set:kGAIScreenName
                                       value:@"view controller"];
    
    // Send the screen view.
    // Previous V3 SDK versions.
    // [[GAI sharedInstance].defaultTracker
    //     send:[[GAIDictionaryBuilder createAppView] build]];
    
    // SDK Version 3.08 and up.
    [[GAI sharedInstance].defaultTracker
     send:[[GAIDictionaryBuilder createScreenView] build]];
}


//(void)startLocating:(NSNotification *)notification {
//    
//    NSDictionary *dict = [notification userInfo];
//    //    or
//    //    NSDictionary *dict = [notification object];
//    
//}


-(void) showShareActivity
{
    NSString *shareText = @"share text";
    NSArray *itemsToShare = @[shareText];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
        activityVC.excludedActivityTypes = @[];
    
//    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
//                                    UIActivityTypePostToWeibo,
//                                    UIActivityTypeMessage, UIActivityTypeMail,
//                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
//                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
//                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
//                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
//    activityVC.excludedActivityTypes = excludedActivities;
//    
    
//   [[SlideNavigationController sharedInstance] pushViewController:activityVC animated:YES];
//    
     // For Iphone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityVC];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
//   [self presentViewController:activityVC animated:YES completion:nil];
    

}

-(void) showAtAppearTime
{
   
    
       [self.webView reload];
    [self setEmptyWebview];

    titleLbl.text = @"Cafe Lagarto";
    if(self.titleOfController.length > 0)
        titleLbl.text = self.titleOfController;
    
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
   
    NSString *urlAddress = @"http://7dci.com.au/lagarto/menu.html";
    if(self.urlStr.length > 0)
        urlAddress = self.urlStr;
    NSURL *url = [NSURL URLWithString:urlAddress];
   NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
//   NSMutableURLRequest *requestObject = [NSMutableURLRequest requestWithURL:url      //[NSURL URLWithString:localUrl]
//                            cachePolicy:NSURLRequestReloadIgnoringCacheData
//                        timeoutInterval:10000];
//    [requestObject setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    
//    [self.webView loadRequest:requestObject];
//    
   //   [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.webView loadRequest:requestObj];
   // [self.webView reload];
   
  
    //[self.view addSubview:webView];
 }

-(void)setEmptyWebview
{
    
    NSString *urlAddress = @"";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    //[self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sidebarButton:(id)sender {
    
    
   
    if (freeCliamDone)
    {
      [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"FreeCliamDonee"];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
      [[SlideNavigationController sharedInstance] toggleLeftMenu];
    }

//-(void) showIndecator
//{
//    [indecator startAnimating];
//    [self.view setUserInteractionEnabled:NO];
//}
//
//-(void) hideIndecator
//{
//    [indecator stopAnimating];
//    [self.view setUserInteractionEnabled:YES];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
     freeCliamDone = [[NSUserDefaults standardUserDefaults] objectForKey:@"FreeCliamDone"];
    
    
    NSString *urlString = [[request URL] absoluteString];
    
    NSString *sourcePathStr = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
  if([sourcePathStr rangeOfString:@"val://get_var"].location != NSNotFound)
    {
        
        NSArray *strArr = [sourcePathStr componentsSeparatedByString:@"?"];
        NSString *keyAndVal = [strArr lastObject];
        NSArray *valArr = [keyAndVal componentsSeparatedByString:@":"];
        
        NSString *keyStr = @"";
        keyStr = [valArr firstObject];
        NSString *valStr = @"0";
        valStr = [valArr lastObject];

        [[NSUserDefaults standardUserDefaults] setObject:valStr forKey:keyStr];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
//        NSString *javaScript = [NSString stringWithFormat:@"getVar()"];
//        NSString *response =   [webView stringByEvaluatingJavaScriptFromString:javaScript];
//        
//        if(!response)
//        {
//            response = @"0";
//        }
//        
//        [[NSUserDefaults standardUserDefaults] setObject:response forKey:@"tag"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        return NO;
        
    }
    else if([sourcePathStr rangeOfString:@"val://set_var"].location != NSNotFound)
    {
        
        NSArray *strArr = [sourcePathStr componentsSeparatedByString:@"?"];
        NSString *key = @"";
        key = [strArr lastObject];
        NSString *value = @"0";
        if(key && key.length > 0)
        {
            if([[NSUserDefaults standardUserDefaults] objectForKey:key])
             value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        }
        
//        NSString *val = @"45";
//        NSString *tag = @"0";
//        
//        if([[NSUserDefaults standardUserDefaults] objectForKey:@"tag"])
//        {
//            tag = [[NSUserDefaults standardUserDefaults] objectForKey:@"tag"];
//        }
//        
        NSString *javaScript = [NSString stringWithFormat:@"setVar('%@', '%@')",key,value,nil];
        [webView stringByEvaluatingJavaScriptFromString:javaScript];
        
         return NO;
    }
    else if([sourcePathStr rangeOfString: @"FC||"].location != NSNotFound)
    {
       
        NSArray *arr = [sourcePathStr componentsSeparatedByString: @"FC||"];
        
        
        
        NSString *linkStr = [[arr lastObject] stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"FreeCliamDone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
        
        for (id obj in controllers) {
            if([obj isKindOfClass:[ViewController class]])
            {
                ViewController *controller = (ViewController *)obj;
                
                controller.titleOfController = @"Thank You";
                controller.urlStr = linkStr;
                [controller showAtAppearTime];
                
                [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
                return YES;
            }
        }
        
        ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
        controller.titleOfController = @"Thank You";
        controller.urlStr = linkStr;
        [controller showAtAppearTime];
        [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
        return NO;
        
       }
    return YES;
   
//  [indecator startAnimating];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [indecator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [indecator stopAnimating];
}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
//{
//  [indecator stopAnimating];
//    
////   UIAlertView *failed = [[UIAlertView alloc] initWithTitle:@"Sorry, failed to load page. " message:@"check ur internet connection" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
////   
////    [failed show];
//  
//}

@end

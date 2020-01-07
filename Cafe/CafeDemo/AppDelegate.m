//
//  AppDelegate.m
//  CafeDemo
//
//  Created by iPHTech11 on 29/02/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import "AppDelegate.h"
#import "utility.h"
#import "SlideNavigationController.h"
#import "LeftPanelViewController.h"
#import "ViewController.h"//UA-79023204-1
#define APP_DISPLAY_NAME @"Cafe Lagarto"
/** Google Analytics configuration constants **/
//static NSString *const kGaPropertyId = @"UA-74679006-1"; // Old
static NSString *const kGaPropertyId = @"UA-79023204-1";//Devesh June 9
static NSString *const kTrackingPreferenceKey = @"allowTracking";
static BOOL const kGaDryRun = NO;
static int const kGaDispatchPeriod = 30;

@interface AppDelegate ()
- (void)initializeGoogleAnalytics;






@end




@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
// for sliding window of navigation
    
    // Generate the UUID
    [utility generateUniqueUUIDandSaveInKeyChain];
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LeftPanelViewController *leftMenu = [storyboard instantiateViewControllerWithIdentifier:@"LeftPanelViewController"];
    
    //   SlideNavigationController *slideNavigationController = [[SlideNavigationController alloc] initWithRootViewController:self.viewController];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];

    
    
    
    
    [application setStatusBarHidden:NO];

    
// then initialize Google Analytics.
    [self initializeGoogleAnalytics];
   
// for crash
    [ Fabric with:@[[Crashlytics class]]];
    
// for push notification
    
    NSNumber *isAllowed = [[NSUserDefaults standardUserDefaults] objectForKey:@"PNallow"];
//  BOOL key = [[NSUserDefaults standardUserDefaults] boolForKey:@"clicked"];  
//    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"isCustomFirstTime"] isEqualToString:@"Yes"]){
//        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"isCustomFirstTime"];
//        [[NSUserDefaults standardUserDefaults] synchronize];

    if(!isAllowed || [isAllowed  intValue] == 0)
   {
//      UIAlertView *showPushNotification= [[UIAlertView alloc] initWithTitle:@"Welcome in Cafe Lagarto" message:@"Would you like to enable push notification" delegate:self cancelButtonTitle:@"Don't Allow" otherButtonTitles:@"OK",nil];
//        showPushNotification.tag= 101;
//        [showPushNotification show];
       
       
       [self showAlet];
    }
    else
    {
     [self showPushNotification];
    
     }
    
    return YES;
}
- (void)initializeGoogleAnalytics {
    
    [[GAI sharedInstance] setDispatchInterval:kGaDispatchPeriod];
    [[GAI sharedInstance] setDryRun:kGaDryRun];
    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:kGaPropertyId];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kTrackingPreferenceKey];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSString *tokenStr = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *UDID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://www.iphmusic.com/CafeLagarto/collect_id.php?registration_id=%@&device_os=%@&udid=%@",tokenStr,@"ios",UDID];
    
    NSLog(@"the device token%@",deviceToken);
    NSLog(@"the url string %@",urlStr);
          NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection start];
// For hide the button of get free coffee in navigation bar
    
    
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ForceUpdateLocation" object:self userInfo:[NSDictionary dictionaryWithObject:@"1,2,3,4,5" forKey:@"categories_ids"]];

    
// For show the thank you page
      
}






- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // For show the button of get free coffee in navigation bar
    
    
    // Inform the user that registration failed.
    NSLog(@"Failed to get token, error: %@", error);
    UIAlertView *failed = [[UIAlertView alloc] initWithTitle:@"Sorry " message:@"Its looks like we are having trouble trying to register you for the push notification " delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [failed show];
    
    // Optional: do you want to show the alert view in every 5 min for allow push notification
    //[NSTimer scheduledTimerWithTimeInterval:5*60 target:self selector:@selector(showAlert:) userInfo:nil repeats:NO];
    
    
    

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary* )userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
{
    //Called when the OS receives a RemoteNotification and the app is running (in the background/suspended or in the foreground.
    
    NSString *url_String1 = (NSString* )[[userInfo objectForKey:@"aps"] objectForKey:@"url"];
    
    
    for(NSString *key in [userInfo allKeys])
    {
        NSLog(@"%@",[userInfo objectForKey:key]);
    }
    
//    for (id key in userInfo) {
//        NSLog(@”key: %@, value: %@”, key, [userInfo objectForKey:key]);
//    }
    
    
    NSString *sourcePathStr = [url_String1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    if ([sourcePathStr rangeOfString:@"VC||"].location == NSNotFound) {
        NSLog(@"string does not contain VC||");
        
        
    } else {
        
        NSArray *arr = [sourcePathStr componentsSeparatedByString: @"VC||"];
        
        
        
        NSString *linkStr = [[arr lastObject] stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
        
        [[NSUserDefaults standardUserDefaults] setObject:linkStr forKey:@"Broucher"];
        [[NSUserDefaults standardUserDefaults] synchronize];

   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    
//    if (url_String1!=nil) {
//        if(![url_String1 isKindOfClass:[NSNull class]])
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:url_String1 forKey:@"PUSH_URL"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        
////        
////            NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
////            
////            for (id obj in controllers) {
////                if([obj isKindOfClass:[ViewController class]])
////                {
////                    ViewController *controller = (ViewController *)obj;
////                    
////                    controller.titleOfController = @"Push_URL";
////                    controller.urlStr = @"http://www.7dci.com.au/lagarto/thankyou.html";
////                    [controller showAtAppearTime];
////                    
////                    [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
////                    return;
////                }
////            }
////            
////            ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
////            controller.titleOfController = @"Push_URL";
////            controller.urlStr = @"http://www.7dci.com.au/lagarto/thankyou.html";
////            [controller showAtAppearTime];
////            [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
////        
//        
//        
//        
//        
//        }
//        
//    }
    
    if (application.applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Push Notification" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok",nil];
        alertView.tag = 102;
        [alertView show];
        
        handler(UIBackgroundFetchResultNewData);
        
    }
    else if (application.applicationState == UIApplicationStateBackground || application.applicationState == UIApplicationStateInactive)
    {
       
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"PNBroucher"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
            NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
            
            for (id obj in controllers) {
                if([obj isKindOfClass:[ViewController class]])
                {
                    ViewController *controller = (ViewController *)obj;
                    
                    controller.titleOfController = @"Voucher";
                    controller.urlStr = linkStr;
                    [controller showAtAppearTime];
                    
                    [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
                }
            }
            
//            ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
//            controller.titleOfController = @"Voucher";
//            controller.urlStr =linkStr;
//            [controller showAtAppearTime];
//            [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
        
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Do something else rather than showing an alert view, because it won't be displayed.
//        
//        if(url_String1!=nil)
//            // [self openNotification_URL:url_String1];
//            [self performSelector:@selector(openNotification_URL:) withObject:url_String1 afterDelay:0.1f];
        
        handler(UIBackgroundFetchResultNewData);
        
    }
}

// Method: for show alert in 5 min for push notification
//- (void) showAlert:(NSTimer *) timer {
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Register notification"
//                                                     message:@"please allow for register notification"
//                                                    delegate:self
//                                           cancelButtonTitle:@"OK"
//                                           otherButtonTitles:nil];
//    [alert show];
//    
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:(void (^)   (UIBackgroundFetchResult))completionHandler {
//    
//    NSLog(@"Notification received: %@", userInfo);
//    completionHandler(UIBackgroundFetchResultNewData);
//}

-(void) showAlet
{

    UIAlertView *showPushNotification= [[UIAlertView alloc] initWithTitle:@"Welcome in Cafe Lagarto" message:@"Would you like to enable push notification" delegate:self cancelButtonTitle:@"Don't Allow" otherButtonTitles:@"OK",nil];
    showPushNotification.tag= 101;
    [showPushNotification show];


}






-(void) showPushNotification
{

    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        // For iOS 8
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        
        
        
        
        
    }
    else
    {
        // For iOS < 8
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }


}

- (void )alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 102)
    {
        
        if (buttonIndex == 0)
        {
         
        }
        
        if(buttonIndex == 1)
            
        {
           
            
            [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"PNBroucher"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            
            
            NSString *broucher_Str = [[NSUserDefaults standardUserDefaults] objectForKey:@"Broucher"];
            
            
            
            NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
            
            for (id obj in controllers) {
                if([obj isKindOfClass:[ViewController class]])
                {
                    ViewController *controller = (ViewController *)obj;
                    
                    controller.titleOfController = @"Voucher";
                    controller.urlStr = broucher_Str;

                    [controller showAtAppearTime];
                    
                    [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
                    return;
                }
            }
            
            ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
            controller.titleOfController = @"Voucher";
            controller.urlStr = broucher_Str;

            [controller showAtAppearTime];
            [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
            
        }
}
    
    
    
    
    
    if(alertView.tag == 101)
     {
         
         if (buttonIndex == 0)
         {
             [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"PNallow"];
             [[NSUserDefaults standardUserDefaults] synchronize];
         }
    
    
         if(buttonIndex == 1)
        
         {
        
        
             [self showPushNotification];
        
             [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"PNallow"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
        
             for (id obj in controllers) {
                 if([obj isKindOfClass:[ViewController class]])
                 {
                     ViewController *controller = (ViewController *)obj;
                
                     controller.titleOfController = @"Thank You";
                     controller.urlStr = @"http://www.7dci.com.au/lagarto/thankyou.html";
                     [controller showAtAppearTime];
                
                     [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
                     return;
                 }
            }
        
        ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
        controller.titleOfController = @"Thank You";
        controller.urlStr = @"http://www.7dci.com.au/lagarto/thankyou.html";
        [controller showAtAppearTime];
        [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
   
        
    }    
}
}


@end

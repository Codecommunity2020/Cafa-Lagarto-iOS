//
//  AppDelegate.h
//  CafeDemo
//
//  Created by iPHTech11 on 29/02/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{
    NSUserDefaults *userDefaults;

}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<GAITracker> tracker;
-(void) showPushNotification;
-(void) showAlet;

@end


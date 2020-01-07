//
//  LeftPanelViewController.m
//  CafeDemo
//
//  Created by iPHTech11 on 01/03/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import "LeftPanelViewController.h"
#import "SlideNavigationController.h"
#import "ViewController.h"
@interface LeftPanelViewController ()

@end

@implementation LeftPanelViewController
@synthesize getFreeButton,bttonImage,bttonLabl,thankYouBttonImage,thankYouBttonLbl,appDel;
- (void)viewDidLoad {
    [super viewDidLoad];
   // Showing if push notification button clicked not allow
    appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   



    
    NSNumber *isAllowed = [[NSUserDefaults standardUserDefaults] objectForKey:@"PNallow"];
    NSNumber *freeCliamDone = [[NSUserDefaults standardUserDefaults] objectForKey:@"FreeCliamDone"];
    
    if (!freeCliamDone)
    {
        
        
        if(!isAllowed || [isAllowed  intValue] == 0)
        {
            
            //
            self.getFreeButton.hidden = NO;
            self.bttonImage.hidden = NO;
            self.bttonLabl.hidden = NO;
            //        self.thankYouBttonLbl.hidden = YES;
            //        self.thankYouBttonImage.hidden = YES;
            //        self.thankYouBtton.hidden = YES;
        }
        
        else
        {
            //        self.getFreeButton.hidden = YES;
            //        self.bttonImage.hidden = YES;
            //        self.bttonLabl.hidden = YES;
            //        self.thankYouBttonLbl.hidden = NO;
            //        self.thankYouBttonImage.hidden = NO;
            //        self.thankYouBtton.hidden = NO;
            UIImage *image=[[UIImage alloc]init];
            image=[UIImage imageNamed:@"Menu"];
            bttonImage.image= image;
            bttonLabl.text = @"Thank You";
        }
    }
    else
    {
        
        self.getFreeButton.hidden = YES;
        self.bttonImage.hidden = YES;
        self.bttonLabl.hidden = YES;
        
    }
    
    NSNumber *broucher = [[NSUserDefaults standardUserDefaults] objectForKey:@"PNBroucher"];
    if (broucher){
        
        
        
        self.getFreeButton.hidden = NO;
        self.bttonImage.hidden = NO;
        self.bttonLabl.hidden = NO;
        
        UIImage *image=[[UIImage alloc]init];
        image=[UIImage imageNamed:@"Menu"];
        bttonImage.image= image;
        bttonLabl.text = @"Voucher";
    }

    
    








}
- (void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    //    NSNumber *freeCliamDonee = [[NSUserDefaults standardUserDefaults] objectForKey:@"FreeCliamDonee"];
    //    if (freeCliamDonee)
    //    {
    //        self.getFreeButton.hidden = YES;
    //        self.bttonImage.hidden = YES;
    //        self.bttonLabl.hidden = YES;
    //    }
    
}




-(void) doNotShowThankyou
{


    self.getFreeButton.hidden = YES;
    self.bttonImage.hidden = YES;
    self.bttonLabl.hidden = YES;


}
-(void)viewWillDisappear:(BOOL)animated
{
}

-(void)viewWillLayoutSubviews
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Button

- (IBAction)menuBtton:(id)sender {
    
    NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
    
    for (id obj in controllers) {
        if([obj isKindOfClass:[ViewController class]])
        {
            ViewController *controller = (ViewController *)obj;
            
            controller.titleOfController = @"Menu";
            controller.urlStr = @"http://7dci.com.au/lagarto/menu.html";
            [controller showAtAppearTime];
            
            [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
            return;
        }
    }
    
    ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
    controller.titleOfController = @"Menu";
    controller.urlStr = @"http://7dci.com.au/lagarto/menu.html";
    [controller showAtAppearTime];
    [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
}

- (IBAction)shareBtton:(id)sender {
    
    NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
    
    for (id obj in controllers) {
        if([obj isKindOfClass:[ViewController class]])
        {
            ViewController *controller = (ViewController *)obj;
            
           // controller.titleOfController = @"Share";

            [controller showShareActivity];
            
            [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
            return;
        }
    }
    
    ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
   // controller.titleOfController = @"Share";
    [controller showShareActivity];
    [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];



}


- (IBAction)specialBtton:(id)sender {
    
    
    NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
    
    for (id obj in controllers) {
        if([obj isKindOfClass:[ViewController class]])
        {
            ViewController *controller = (ViewController *)obj;
            
            controller.titleOfController = @"Specials";
            controller.urlStr = @"http://www.7dci.com.au/lagarto/specials.html";
            [controller showAtAppearTime];
            [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
            return;
        }
    }
    
    ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
    controller.titleOfController = @"Specials";
    controller.urlStr = @"http://www.7dci.com.au/lagarto/specials.html";
    [controller showAtAppearTime];
    [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
}


- (IBAction)contactUs:(id)sender {
    
    
    NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
    
    for (id obj in controllers) {
        if([obj isKindOfClass:[ViewController class]])
        {
            ViewController *controller = (ViewController *)obj;
            
            controller.titleOfController = @"Contact Us";
            controller.urlStr = @"http://7dcinteractive.com.au/lagarto/contact.html";
             [controller showAtAppearTime];
            [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
            return;
        }
    }
    
    ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
    controller.titleOfController = @"Contact Us";
    controller.urlStr = @"http://7dcinteractive.com.au/lagarto/contact.html";
     [controller showAtAppearTime];
    [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
    
    
}


- (IBAction)openHoursBtton:(id)sender {
    
    NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
    
    for (id obj in controllers) {
        if([obj isKindOfClass:[ViewController class]])
        {
            ViewController *controller = (ViewController *)obj;
            
            controller.titleOfController = @"Open Hours";
            controller.urlStr = @"http://www.7dci.com.au/lagarto/openinghours.html";
            [controller showAtAppearTime];
            [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
            return;
        }
    }
    
    ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
    controller.titleOfController = @"Open Hours";
    controller.urlStr = @"http://www.7dci.com.au/lagarto/openinghours.html";
    [controller showAtAppearTime];
    
    [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
}

- (IBAction)getGreeCoffeeBttonClicked:(id)sender {
    
    NSNumber *isAllowed = [[NSUserDefaults standardUserDefaults] objectForKey:@"PNallow"];
    NSNumber *broucher = [[NSUserDefaults standardUserDefaults] objectForKey:@"PNBroucher"];
     if (broucher)
     {
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
    
    
    
    
    if(!isAllowed || [isAllowed  intValue] == 0)
    {
    NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
    
    for (id obj in controllers) {
        if([obj isKindOfClass:[ViewController class]])
        {
            ViewController *controller = (ViewController *)obj;
            
//            controller.titleOfController = @"Get Free Coffee ";
//            controller.urlStr = @"http://7dci.com.au/lagarto/menu.html";
//            [controller showAtAppearTime];
//            [appDel showPushNotification];
            [appDel showAlet];
            [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
            return;
        }
    }
    
    ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
//    controller.titleOfController = @"Get Free Coffee ";
//    controller.urlStr = @"http://7dci.com.au/lagarto/menu.html";
//    [controller showAtAppearTime];
//  [appDel showPushNotification];
        [appDel showAlet];
    [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];
    }
    else
    {
    
        NSArray *controllers = [SlideNavigationController sharedInstance].viewControllers;
        
        for (id obj in controllers) {
            if([obj isKindOfClass:[ViewController class]])
            {
                ViewController *controller = (ViewController *)obj;
                
               controller.titleOfController = @"Thank You";
                controller.urlStr = @"http://www.7dci.com.au/lagarto/thankyou.html";
                [controller showAtAppearTime];
//                [appDel showPushNotification];
                
                [[SlideNavigationController sharedInstance] popToViewController:controller animated:YES];
                return;
            }
        }
        
        ViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil ] instantiateViewControllerWithIdentifier:@"ViewController"];
        controller.titleOfController = @"Thank You";
        controller.urlStr = @"http://www.7dci.com.au/lagarto/thankyou.html";
        [controller showAtAppearTime];
//        [appDel showPushNotification];
        
        [[SlideNavigationController sharedInstance] pushViewController:controller animated:YES];

    
    
    
    }
}
- (IBAction)thankuButton:(id)sender {
    
    
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



@end

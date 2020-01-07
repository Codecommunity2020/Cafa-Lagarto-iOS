//
//  ViewController.h
//  CafeDemo
//
//  Created by iPHTech11 on 29/02/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

@interface ViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIActivityIndicatorView *indecator;
    IBOutlet UILabel *titleLbl;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) NSString *titleOfController;
@property (strong,nonatomic) NSString *urlStr;

- (IBAction)sidebarButton:(id)sender;
-(void) showAtAppearTime;
-(void) showShareActivity;

@end


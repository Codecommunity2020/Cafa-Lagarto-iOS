//
//  LeftPanelViewController.h
//  CafeDemo
//
//  Created by iPHTech11 on 01/03/16.
//  Copyright © 2016 iPHTech11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LeftPanelViewController : UIViewController
- (IBAction)menuBtton:(id)sender;

- (IBAction)shareBtton:(id)sender;


- (IBAction)specialBtton:(id)sender;

- (IBAction)contactUs:(id)sender;
- (IBAction)openHoursBtton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *getFreeButton;
- (IBAction)getGreeCoffeeBttonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *bttonImage;
@property (strong, nonatomic) IBOutlet UILabel *bttonLabl;

- (IBAction)thankuButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *thankYouBttonImage;
@property (strong, nonatomic) IBOutlet UILabel *thankYouBttonLbl;
-(void) doNotShowThankyou;
@property(nonatomic, strong) AppDelegate *appDel;
@end

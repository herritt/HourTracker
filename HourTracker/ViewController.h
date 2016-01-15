//
//  ViewController.h
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-09.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nextPay;
@property (weak, nonatomic) IBOutlet UILabel *nextPayDay;
@property (weak, nonatomic) IBOutlet UILabel *eiHoursRemaining;
@property (weak, nonatomic) IBOutlet UILabel *totalHours;
@property (weak, nonatomic) IBOutlet UILabel *payPeriodHours;
@property (weak, nonatomic) IBOutlet UILabel *payDay;
@property (weak, nonatomic) IBOutlet UILabel *pay;
@end


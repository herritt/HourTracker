//
//  RecordHoursViewController.h
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-09.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordHoursViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *hoursTextField;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@end

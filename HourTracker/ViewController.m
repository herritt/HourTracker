//
//  ViewController.m
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-09.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import "ViewController.h"
#import "SavedData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initText];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self initText];
}

-(void)initText {
    _totalHours.text = [NSString stringWithFormat:@"%.2lf" , [SavedData getTotalHours]];
    _payPeriodHours.text = [NSString stringWithFormat:@"%.2lf", [SavedData getPayPeriodHours]];
    _eiHoursRemaining.text = [NSString stringWithFormat:@"%.2lf", fmax(0, 560 - [SavedData getTotalHours])];
    _nextPayDay.text = [NSString stringWithFormat:@"%@", [self nextPayDay]];
    _nextPay.text = [NSString stringWithFormat:@"$%.2lf", [SavedData getNextEstimatedPay]];
    _payDay.text = [NSString stringWithFormat:@"%@", [self thisPayDay]];    
    _pay.text = [NSString stringWithFormat:@"$%.2lf", [SavedData getThisEstimatedPay]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString*)thisPayDay {
    return [self getPayDayFromDate:[SavedData getThisPayDay]];
    
}

-(NSString*)nextPayDay {
    return [self getPayDayFromDate:[SavedData getNextPayDay]];
}

-(NSString*)getPayDayFromDate:(NSDate*)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSString *month;
    switch ([components month]) {
        case 1:
            month = @"Jan";
            break;
        case 2:
            month = @"Feb";
            break;
        case 3:
            month = @"Mar";
            break;
        case 4:
            month = @"Apr";
            break;
        case 5:
            month = @"May";
            break;
        case 6:
            month = @"Jun";
            break;
        case 7:
            month = @"Jul";
            break;
        case 8:
            month = @"Aug";
            break;
        case 9:
            month = @"Sep";
            break;
        case 10:
            month = @"Oct";
            break;
        case 11:
            month = @"Nov";
            break;
        case 12:
            month = @"Dec";
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%ld %@", (long)[components day], month];
    
    
}



@end

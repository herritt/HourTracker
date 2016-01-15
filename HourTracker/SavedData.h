//
//  SavedData.h
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-10.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HourData.h"

@interface SavedData : NSObject

+ (void)updateData:(HourData*)newData;
+ (double)getTotalHours;
+ (double)getPayPeriodHours;
+ (double)getNextEstimatedPay;
+ (double)getThisEstimatedPay;
+ (NSDate*)getNextPayDay;
+ (NSDate*)getThisPayDay;
+ (NSMutableArray*)getSavedData;

@end

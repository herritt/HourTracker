//
//  Hour.h
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-09.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourData : NSObject <NSCoding, NSCopying>

-(id)initWithDate:(NSDate*)aDate andHours:(NSString*)hours;

@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString * hours;

@end

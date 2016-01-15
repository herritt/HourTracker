//
//  SavedData.m
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-10.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import "SavedData.h"

@implementation SavedData

+(double)getThisEstimatedPay {
    
    double estPay = 0;
    double regularHours = 0;
    double timeAndHalfHours = 0;
    double doubleTimeHours = 0;
    
    NSDate *datePayPeriodStarted = [self getDateFromPayPeriodStartByAdding:-14];
    
    NSMutableArray *savedData = [self getSavedData];
    for (HourData* data in savedData) {
        if ([self daysBetween:data.date and:datePayPeriodStarted] < 14
            && ([data.date compare:datePayPeriodStarted] == NSOrderedDescending
                || [data.date compare:datePayPeriodStarted] == NSOrderedSame)
            ) {
            
            double hours = [data.hours doubleValue];
            if (hours > 10) {
                doubleTimeHours+=(hours - 10);
                hours = 10;
            }
            if (hours > 8) {
                timeAndHalfHours+=(hours-8);
                hours = 8;
            }
            regularHours+=hours;
        }
    }
    
    double rateOfPay = 24.54;
    
    estPay = (regularHours*rateOfPay+timeAndHalfHours*rateOfPay*1.5+doubleTimeHours*rateOfPay*2)*.7;
    return estPay;
}

+(double)getNextEstimatedPay {
    
    double estPay = 0;
    double regularHours = 0;
    double timeAndHalfHours = 0;
    double doubleTimeHours = 0;
    
    NSDate *datePayPeriodStarted = [self getPayPeriodStartDate];
    
    NSMutableArray *savedData = [self getSavedData];
    for (HourData* data in savedData) {
        if ([self daysBetween:data.date and:datePayPeriodStarted] < 14
            && ([data.date compare:datePayPeriodStarted] == NSOrderedDescending
                || [data.date compare:datePayPeriodStarted] == NSOrderedSame)
            ) {
            
            double hours = [data.hours doubleValue];
            if (hours > 10) {
                doubleTimeHours+=(hours - 10);
                hours = 10;
            }
            if (hours > 8) {
                timeAndHalfHours+=(hours-8);
                hours = 8;
            }
            regularHours+=hours;
        }
    }
    
    double rateOfPay = 24.54;
    
    estPay = (regularHours*rateOfPay+timeAndHalfHours*rateOfPay*1.5+doubleTimeHours*rateOfPay*2)*.7;
    return estPay;
    
}


+(NSDate*)getDateFromPayPeriodStartByAdding:(int)days  {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    comps = [NSDateComponents new];
    comps.month = 0;
    comps.year = 0;
    comps.day = days;
    NSDate *payDay = [calendar dateByAddingComponents:comps toDate:[self getPayPeriodStartDate] options:0];
    return payDay;
}

+(NSDate*)getThisPayDay {
    return [self getDateFromPayPeriodStartByAdding:11];
}


+(NSDate*)getNextPayDay {
    return [self getDateFromPayPeriodStartByAdding:25];
}

+(NSDate*)getPayPeriodStartDate {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:20];
    [comps setMonth:12];
    [comps setYear:2015];
    NSDate *baseDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    //number of days since baseDate
    int daysSince = [self daysBetween:baseDate and:[NSDate date]];
    
    int daysSincePayPeriodStart = daysSince % 14;
    
    //get previous date
    NSCalendar *calendar = [NSCalendar currentCalendar];
    comps = [NSDateComponents new];
    comps.month = 0;
    comps.year = 0;
    comps.day   = -daysSincePayPeriodStart;
    NSDate *datePayPeriodStarted = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    
    return datePayPeriodStarted;
    
}


+(double)getPayPeriodHours {
    
    double payPeriodHours = 0;
    
    NSDate *datePayPeriodStarted = [self getPayPeriodStartDate];
    
    NSMutableArray *savedData = [self getSavedData];
    for (HourData* data in savedData) {
        
        if ([self daysBetween:data.date and:datePayPeriodStarted] < 14
            && ([data.date compare:datePayPeriodStarted] == NSOrderedDescending
            || [data.date compare:datePayPeriodStarted] == NSOrderedSame)
            ) {
            payPeriodHours += [data.hours doubleValue];
        }
    }
    
    return payPeriodHours;
}

+(double)getTotalHours {
    
    double totalHours = 0;
    
    NSMutableArray *savedData = [self getSavedData];
    for (HourData* data in savedData) {
        
        totalHours += [data.hours doubleValue];
        
    }
    
    return totalHours;
}

+(void)updateData:(HourData *)newData {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:newData.date];

    //break up the data to enter into components
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    //get the saved data
    NSMutableArray *contentsOfFile = [self getSavedData];

    
    //check to see if the date already exists
    BOOL dateExisted = NO;
    
    for (HourData* data in contentsOfFile) {
        
        NSDateComponents *thisComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:data.date];
        
        //break up the data to enter into components
        NSInteger thisDay = [thisComponent day];
        NSInteger thisMonth = [thisComponent month];
        NSInteger thisYear = [thisComponent year];
        
        if (thisDay == day && thisMonth == month && thisYear == year) {
            dateExisted = YES;
 
            //overwrite this data
            data.hours = newData.hours;
            
        }
    }
    
    if (!dateExisted) {
        [contentsOfFile addObject:newData];
    }
    [self saveData:contentsOfFile];
}

+ (void) saveData:(NSMutableArray*)dataFile {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:dataFile forKey:@"HoursData"];
    [archiver finishEncoding];
    
    [data writeToFile:[self filePath] atomically:YES];
}

+ (NSMutableArray*)getSavedData {
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self filePath]];
    if (data)
    {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSArray *dataDecoded = [unarchiver decodeObjectForKey:@"HoursData"];
        
        
        return [[NSMutableArray alloc] initWithArray:dataDecoded copyItems:NO];
    }
    else return [[NSMutableArray alloc] init];
}

+ (NSString *)filePath {
    static NSString* documentsDirectory = nil;
    if (documentsDirectory == nil) {
        documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask,
                                                                  YES)
                              objectAtIndex:0];
    }
    return [documentsDirectory stringByAppendingPathComponent:@"SavedFile"];
 
}

+ (int)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
   NSUInteger unitFlags = NSCalendarUnitDay;
   NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
   NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
   return (int)[components day];
}

@end

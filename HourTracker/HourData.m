//
//  Hour.m
//  HourTracker
//
//  Created by Randy Herritt on 2016-01-09.
//  Copyright © 2016 Randy Herritt. All rights reserved.
//

#import "HourData.h"

@implementation HourData

-(id)initWithDate:(NSDate *)date andHours:(NSString*)hours {
    if (self =[super init]) {
        _date = date;
        _hours = hours;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_hours forKey:@"hours"];
}

-(id)copyWithZone:(NSZone *)zone {
    HourData* copy = [[[self class] allocWithZone:zone] init];
    copy.date = _date;
    copy.hours = _hours;
    return copy;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        _date = [aDecoder decodeObjectForKey:@"date"];
        _hours = [aDecoder decodeObjectForKey:@"hours"];
        
    }
    return self;
}
- (NSComparisonResult)compare:(HourData *)otherObject {
    return [self.date compare:otherObject.date];
}

@end

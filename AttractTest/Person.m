//
//  Person.m
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setupPersonWith:dict];
    }
    return self;
}

- (void)setupPersonWith:(NSDictionary *)dict {
    self.name = dict[@"name"];
    self.personDescription = dict[@"description"];
    self.date = [self getDateFromTime:[dict[@"time"] doubleValue]/1000];
    self.imageURL = dict[@"image"];
    self.itemId = [NSString stringWithFormat:@"%ld", (unsigned long)[dict[@"itemId"] integerValue]];
}

- (NSString *)getDateFromTime:(NSTimeInterval)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [formatter setDateFormat:@"dd-LLLL-yyyy  HH:mm"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    return [formatter stringFromDate:date];
}


@end

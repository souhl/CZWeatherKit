//
//  CZWeatherCondition.m
//  CZWeatherKit
//
//  Copyright (c) 2015 Comyar Zaheri. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//


#pragma mark - Imports

#import "CZWeatherCurrentCondition.h"
#import "CZWeatherCurrentCondition+Internal.h"


#pragma mark - CZWeatherCurrentCondition Class Extension

@interface CZWeatherCurrentCondition ()

@property (NS_NONATOMIC_IOSONLY) NSDate *date;
@property (NS_NONATOMIC_IOSONLY) NSString *summary;
@property (assign, NS_NONATOMIC_IOSONLY) Climacon climacon;
@property (assign, NS_NONATOMIC_IOSONLY) CZHumidity humidity;
@property (assign, NS_NONATOMIC_IOSONLY) CZPressure pressure;
@property (assign, NS_NONATOMIC_IOSONLY) CZWindSpeed windSpeed;
@property (assign, NS_NONATOMIC_IOSONLY) CZWindDirection windDirection;
@property (assign, NS_NONATOMIC_IOSONLY) CZTemperature temperature;

@end


#pragma mark - CZWeatherCurrentCondition Implementation

@implementation CZWeatherCurrentCondition

- (instancetype)_init
{
    if (self = [super init]) {
        // nothing to do
    }
    return self;
}

#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.date = [aDecoder decodeObjectOfClass:[NSDate class] forKey:@"date"];
        self.summary = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"summary"];
        self.climacon = [aDecoder decodeIntegerForKey:@"climacon"];
        self.humidity = [aDecoder decodeFloatForKey:@"humidity"];
        self.windDirection = [aDecoder decodeFloatForKey:@"windDirection"];
        
        NSValue *pressureValue = [aDecoder decodeObjectOfClass:[NSValue class] forKey:@"pressure"];
        [pressureValue getValue:&_pressure];
        
        NSValue *windSpeedValue = [aDecoder decodeObjectOfClass:[NSValue class] forKey:@"windSpeed"];
        [windSpeedValue getValue:&_windDirection];
        
        NSValue *temperatureValue = [aDecoder decodeObjectOfClass:[NSValue class] forKey:@"temperature"];
        [temperatureValue getValue:&_temperature];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.summary forKey:@"summary"];
    [aCoder encodeInteger:self.climacon forKey:@"climacon"];
    [aCoder encodeFloat:self.humidity forKey:@"humidity"];
    [aCoder encodeFloat:self.windDirection forKey:@"windDirection"];
    
    NSValue *pressureValue = [NSValue value:&_pressure withObjCType:@encode(CZPressure)];
    [aCoder encodeObject:pressureValue forKey:@"pressure"];
    
    NSValue *windSpeedValue = [NSValue value:&_windSpeed withObjCType:@encode(CZWindSpeed)];
    [aCoder encodeObject:windSpeedValue forKey:@"windSpeed"];
    
    NSValue *temperatureValue = [NSValue value:&_temperature withObjCType:@encode(CZTemperature)];
    [aCoder encodeObject:temperatureValue forKey:@"temperature"];
}

#pragma mark NSSecureCoding

+ (BOOL)supportsSecureCoding
{
    return YES;
}

#pragma mark NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    CZWeatherCurrentCondition *copy = [[CZWeatherCurrentCondition alloc]_init];
    copy.date = [self.date copy];
    copy.summary = [self.summary copy];
    copy.climacon = self.climacon;
    copy.humidity = self.humidity;
    copy.pressure = self.pressure;
    copy.windDirection = self.windDirection;
    copy.windSpeed = self.windSpeed;
    copy.temperature = self.temperature;
    return copy;
}

@end

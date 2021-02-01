//
//  Car.m
//  WYHPredicate
//
//  Created by wyh on 2021/1/26.
//

#import "Car.h"


@implementation Car

- (instancetype)initWithName:(NSString *)name make:(NSString *)make model:(NSString *)model modelYear:(NSInteger)modelYear numberOfDoors:(NSInteger)numberOfDoors mileage:(float)mileage horsepower:(NSInteger)horsepower
{
    if (self = [super init]) {
        self.tyres = [[NSMutableArray alloc] init];
        self.name = name;
        self.make = make;
        self.model = model;
        self.modelYear = modelYear;
        self.numberOfDoors = numberOfDoors;
        self.mileage = mileage;
        
        Slant6 *engine = [[Slant6 alloc] init];
        [engine setValue:@(horsepower) forKey:@"horsepower"];
        self.engine = engine;
        
        NSInteger tyreTotal = 4;
        NSString *tyreName = @"倍耐力";
        if (horsepower < 50) {
            tyreTotal = 3;
            tyreName = @"马牌";
        }
        for (int i = 0;i<tyreTotal;i++) {
            Tyre *tyre = [[Tyre alloc] init];
            tyre.name = tyreName;
            [self.tyres addObject:tyre];
        }
    }
    return self;
}


@end

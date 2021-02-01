//
//  Garage.m
//  WYHPredicate
//
//  Created by wyh on 2021/1/26.
//

#import "Garage.h"

@implementation Garage

- (instancetype)init
{
    if (self = [super init]) {
        _cars = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addCars:(id)objects
{
    [self.cars addObject:objects];
}


@end

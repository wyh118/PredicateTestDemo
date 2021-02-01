//
//  Car.h
//  WYHPredicate
//
//  Created by wyh on 2021/1/26.
//

#import <Foundation/Foundation.h>
#import "Slant6.h"
#import "Tyre.h"

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject
{
    @public
    NSString *testStr;

}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *make;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, assign) NSInteger modelYear;
@property (nonatomic, assign) NSInteger numberOfDoors;
@property (nonatomic, assign) float mileage;
@property (nonatomic, strong) Slant6 *engine;
@property (nonatomic, strong) NSMutableArray<Tyre *> *tyres;


- (instancetype)initWithName:(NSString *)name make:(NSString *)make model:(NSString *)model modelYear:(NSInteger)modelYear numberOfDoors:(NSInteger)numberOfDoors mileage:(float)mileage horsepower:(NSInteger)horsepower;



@end

NS_ASSUME_NONNULL_END

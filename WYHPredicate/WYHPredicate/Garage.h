//
//  Garage.h
//  WYHPredicate
//
//  Created by wyh on 2021/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Garage : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *cars;

- (void)addCars:(id)objects;

@end

NS_ASSUME_NONNULL_END

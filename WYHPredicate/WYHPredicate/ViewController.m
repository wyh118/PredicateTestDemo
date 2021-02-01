//
//  ViewController.m
//  WYHPredicate
//
//  Created by wyh on 2021/1/26.
//

#import "ViewController.h"
#import "Car.h"
#import "Garage.h"
#import "Slant6.h"


Car * makeCar(NSString *name, NSString *make, NSString *model,int modelYear, int numberOfDoors, float mileage,int horsepower){
    
    Car *car = [[Car alloc] initWithName:name make:make model:model modelYear:modelYear numberOfDoors:numberOfDoors mileage:mileage horsepower:horsepower];
    

    return car;
}

@interface ViewController ()

@end

@implementation ViewController
/*
 %d和%@表示插入数值和字符串，%K表示key值。用$表示引入变量名：如@"name == $NAME",再用predicateWithSubstitutionVariables调用来构造新的谓词{@"NAME":@"Herbie"}键值NAME是变量名对应$NAME，值是要插入的内容，即将$NAME替换为Herbie。
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self handleStrPredicate];
    
    [self handleCodePredicate];
}

- (void)handleCodePredicate
{
    //创建左侧表达式对象 对应为键
    NSExpression *leftExpression = [NSExpression expressionForKeyPath:@"length"];
    //创建右侧表达式对象 对应为值
    NSExpression *rightExpression = [NSExpression expressionForConstantValue:@5];
    //创建比较谓词对象
    NSComparisonPredicate *predicate = [NSComparisonPredicate predicateWithLeftExpression:leftExpression rightExpression:rightExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSCaseInsensitivePredicateOption];
    NSArray * test = @[@"Herbie",@"Badger",@"Elvis",@"Phoenix",@"Streaker"];
    NSArray * results = [test filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",results);
}

- (void)handleStrPredicate
{
    Car *car = makeCar (@"Herbie", @"Honda", @"CRX", 1984, 2, 34000, 58);
    Garage *garage = [[Garage alloc] init];
    garage.name = @"Joe‘s Garage";
    [garage addCars:car];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == 'Herbie'"];
    BOOL match = [predicate evaluateWithObject:car];
    NSLog(@"%@",match?@"YES":@"NO");
    
    predicate = [NSPredicate predicateWithFormat: @"engine.horsepower > 150"];
    match = [predicate evaluateWithObject:car];
    NSLog(@"%s",(match)?"YES":"NO");

    predicate = [NSPredicate predicateWithFormat:@"name == %@",@"Herbie"];
    match = [predicate evaluateWithObject: car];
    NSLog(@"%s",(match)?"YES":"NO");
    
    predicate = [NSPredicate predicateWithFormat:@"%K == %@",@"name",@"Herbie"];
    match = [predicate evaluateWithObject:car];
    NSLog(@"%s",(match)?"YES":"NO");

    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:@"name == $NAME"];
    NSDictionary *varDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Herbie", @"NAME", nil];
    predicate = [predicateTemplate predicateWithSubstitutionVariables:varDict];
    NSLog(@"SNORGLE: %@", predicate);
    match = [predicate evaluateWithObject: car];
    NSLog(@"%s",(match)?"YES":"NO");

    
    Car *car1 = makeCar (@"Badger", @"Acura", @"Integra", 1987, 5, 217036.7, 130);
    [garage addCars: car1];
          
    Car *car2 = makeCar (@"Elvis", @"Acura", @"Legend", 1989, 4, 28123.4, 151);
    [garage addCars: car2];
          
    Car *car3 = makeCar (@"Phoenix", @"Pontiac", @"Firebird", 1969, 2, 85128.3, 345);
    [garage addCars: car3];
          
    Car *car4 = makeCar (@"Streaker", @"Pontiac", @"Silver Streak", 1950, 2, 39100.0, 36);
    [garage addCars: car4];
          
    Car *car5 = makeCar (@"Judge", @"Pontiac", @"GTO", 1969, 2, 45132.2, 370);
    [garage addCars: car5];
          
    Car *car6 = makeCar (@"Paper Car", @"Plymouth", @"Valiant", 1965, 2, 76800, 40);
    [garage addCars: car6];
    
    predicate = [NSPredicate predicateWithFormat:@"engine.horsepower > 150"];
    NSArray *cars = [garage cars];
    for (Car *car in [garage cars]) {
        if ([predicate evaluateWithObject: car]) {
            NSLog (@"%@", car.name);
        }
    }
    
    predicate = [NSPredicate predicateWithFormat: @"engine.horsepower > 150"];
    
    NSArray *results;
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",results);
    
    NSArray *names;
    names = [results valueForKey:@"name"];
    NSLog(@"%@",names);
    
    NSMutableArray *carsCopy = [cars mutableCopy];
    [carsCopy filterUsingPredicate: predicate];
    NSLog (@"%@", carsCopy);
    
    predicate = [NSPredicate predicateWithFormat: @"engine.horsepower > %d", 50];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog (@"%@", results);
    
    predicateTemplate = [NSPredicate predicateWithFormat: @"engine.horsepower > $POWER"];
    varDict = [NSDictionary dictionaryWithObjectsAndKeys:@(150), @"POWER", nil];
    predicate = [predicateTemplate predicateWithSubstitutionVariables: varDict];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog (@"%@", results);
    
    predicate = [NSPredicate predicateWithFormat:@"name < 'Newton'"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog (@"%@", [results valueForKey: @"name"]);
    
    // !!!: 查询horsepower在50到200之间的数据
    predicate = [NSPredicate predicateWithFormat:@"(engine.horsepower > 50) AND (engine.horsepower < 200)"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog (@"AND使用 %@", results);
    
    predicate = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN { 50, 200 }"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog (@"BETWEEN使用 %@", results);
    
    NSArray *betweens = [NSArray arrayWithObjects:@50,@200,nil];
    predicate = [NSPredicate predicateWithFormat: @"engine.horsepower BETWEEN %@", betweens];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog (@"BETWEEN+Array使用 %@", results);
    
    predicateTemplate = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN $POWERS"];
    varDict = [NSDictionary dictionaryWithObjectsAndKeys:betweens, @"POWERS", nil];
    predicate = [predicateTemplate predicateWithSubstitutionVariables:varDict];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog (@"BETWEEN+$方式使用 %@",results);
    
    // !!!: 在给定的范围内查询name
    predicate = [NSPredicate predicateWithFormat:@"name IN {'Herbie', 'Snugs', 'Badger', 'Flap'}"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",[results valueForKey:@"name"]);
    
    predicate = [NSPredicate predicateWithFormat:@"SELF.name IN {'Herbie', 'Snugs', 'Badger', 'Flap'}"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog (@"%@", [results valueForKey: @"name"]);

    names = [cars valueForKey:@"name"];
    predicate = [NSPredicate predicateWithFormat:@"SELF IN {'Herbie', 'Snugs', 'Badger', 'Flap'}"];
    results = [names filteredArrayUsingPredicate: predicate];
    NSLog (@"%@", results);
    
    // !!!: 获取指定字符开头的数据
    predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH 'Bad'"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", results);
    
    predicate = [NSPredicate predicateWithFormat: @"name BEGINSWITH 'HERB'"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog(@"%@", results);
    
    // !!!: 获取指定字符开头的数据，忽略大小写和发音
    predicate = [NSPredicate predicateWithFormat: @"name BEGINSWITH[cd] 'HERB'"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog(@"%@", results);
    
    // !!!: 星号表示任意多
    predicate = [NSPredicate predicateWithFormat:@"name LIKE[cd] '*er*'"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog(@"%@", [results valueForKey:@"name"]);
    
    // !!!: ？表示一个结合使用，“？？？er”表示在er前面有三位
    predicate = [NSPredicate predicateWithFormat: @"name LIKE[cd] '????er*'"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog (@"%@",  [results valueForKey:@"name"]);
    
    NSArray *names1 = [NSArray arrayWithObjects: @"Herbie", @"Badger", @"Judge", @"Elvis", nil];
    NSArray *names2 = [NSArray arrayWithObjects: @"Judge", @"Paper Car", @"Badger", @"Phoenix", nil];
    predicate = [NSPredicate predicateWithFormat:@"SELF IN %@",names1];
    results = [names2 filteredArrayUsingPredicate:predicate];
    NSLog (@"%@", predicate);
    NSLog (@"%@", results);
    
    predicate = [NSPredicate predicateWithFormat: @"modelYear > 1970"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog(@"%@",results);
    
    predicate = [NSPredicate predicateWithFormat:@"name contains[cd] 'er'"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",results);
    
    predicate = [NSPredicate predicateWithFormat: @"name beginswith 'B'"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog (@"%@", [results valueForKey:@"name"]);
    
    predicate = [NSPredicate predicateWithFormat: @"%K beginswith %@",@"name", @"B"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog (@"with args : %@", results);
    
    predicateTemplate = [NSPredicate predicateWithFormat: @"name beginswith $NAME"];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: @"Bad", @"NAME", nil];
    predicate = [predicateTemplate predicateWithSubstitutionVariables:dict];
    NSLog (@"SNORGLE: %@", predicate);
    
    predicate = [NSPredicate predicateWithFormat: @"name in { 'Badger', 'Judge', 'Elvis' }"];
    results = [cars filteredArrayUsingPredicate: predicate];
    NSLog (@"%@", [results valueForKey:@"name"]);
    
    
    predicate = [NSPredicate predicateWithFormat:@"tyres[SIZE] == 3"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", results);
    
    predicate = [NSPredicate predicateWithFormat:@"tyres[1].name == '马牌'"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", results);
    
    predicate = [NSPredicate predicateWithFormat:@"tyres[FIRST].name == '马牌'"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", results);
    
    predicate = [NSPredicate predicateWithFormat:@"tyres[LAST].name == '倍耐力'"];
    results = [cars filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", results);
}


@end

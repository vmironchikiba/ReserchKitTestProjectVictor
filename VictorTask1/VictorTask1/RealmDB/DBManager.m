//
//  DBManager.m
//  VictorTask1
//
//  Created by Mironchik on 27.10.24.
//

#import "DBManager.h"
#import "VictorTask1-Swift.h"

@implementation DBManager

+ (instancetype)sharedInstance {
    static DBManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSError *error = nil;
        _realm = [RLMRealm defaultRealm];
        if (error) {
            NSLog(@"Failed to open Realm: %@", error.localizedDescription);
        }
    }
    return self;
}


- (void)saveSurveyRecord:(NSString *)firstName lastName: (NSString *)lastName age: (NSInteger) age interest: (NSInteger) interest  {
    NSError *error = nil;
    [self.realm transactionWithBlock:^{
        SurveyModel *model = [[SurveyModel alloc] init];
        model.firstName = firstName;
        model.lastName = lastName;
        model.age = age;
        model.interest = interest;
        [self.realm addObject:(RLMObject *)model];
    } error:&error];
    
    if (error) {
        NSLog(@"Error saving SurveyModel to Realm: %@", error.localizedDescription);
    } else {
        NSLog(@"SurveyModel saved successfully.");
    }
}

@end


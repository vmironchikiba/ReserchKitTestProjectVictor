//
//  DBManager.m
//  VictorTask1
//
//  Created by Mironchik on 27.10.24.
//

#import "DBManager.h"
#import "VictorTask1-Swift.h"

@interface DBManager()
 @property (nonatomic, strong) SurveyModel *model;
@end

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
        
        if (self.model == nil) {
            self.model = [[SurveyModel alloc] init];
        }
        
        self.model.firstName = firstName;
        self.model.lastName = lastName;
        self.model.age = age;
        self.model.interest = interest;
        [self.realm addObject:(RLMObject *)self.model];
    } error:&error];
    
    if (error) {
        NSLog(@"Error saving SurveyModel to Realm: %@", error.localizedDescription);
    } else {
        NSLog(@"SurveyModel saved successfully.");
    }
}


- (void)saveFirstName:(NSString *)firstName  {
    if (self.model == nil) {
        self.model = [[SurveyModel alloc] init];
    }
    self.model.firstName = firstName;
}

- (void)saveLastName:(NSString *)lastName  {
    if (self.model == nil) {
        self.model = [[SurveyModel alloc] init];
    }
    self.model.lastName = lastName;
}

- (void)saveAge:(NSInteger) age{
    if (self.model == nil) {
        self.model = [[SurveyModel alloc] init];
    }
    self.model.age = age;
}

- (void)saveEmail:(NSString *)email {
    if (self.model == nil) {
        self.model = [[SurveyModel alloc] init];
    }
    
    self.model.email = email;
}

- (void)saveInterests:(NSInteger) interest  {
    if (self.model == nil) {
        self.model = [[SurveyModel alloc] init];
    }
    
    self.model.interest = interest;
}

- (void)commitRecord {
    NSError *error = nil;
    if (self.model == nil) {
        [self.realm transactionWithBlock:^{
            [self.realm addObject:(RLMObject *)self.model];
        } error:&error];
        
        if (error) {
            NSLog(@"Error saving SurveyModel to Realm: %@", error.localizedDescription);
        } else {
            NSLog(@"SurveyModel saved successfully.");
            self.model = nil;
        }
    }
}

@end


//
//  DBManager.h
//  VictorTask1
//
//  Created by Mironchik on 27.10.24.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject
+ (instancetype)sharedInstance;
- (void)saveSurveyRecord:(NSString *)firstName lastName: (NSString *)lastName age: (NSInteger) age interest: (NSInteger) interest;
@property (nonatomic, strong) RLMRealm *realm;
@end

NS_ASSUME_NONNULL_END

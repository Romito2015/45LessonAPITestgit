//
//  RSServerManager.h
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 17.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSUser;

@interface RSServerManager : NSObject

@property (strong, nonatomic ,readonly) RSUser *currentUser;

+ (RSServerManager *) sharedManager;

- (void) authorizeUser: (void(^) (RSUser *user)) completion;

- (void) getFriendsWithOffset: (NSInteger) offset
                        count: (NSInteger) count
                    onSuccess: (void(^)(NSArray *friends)) success
                    onFailure: (void (^)(NSError *error, NSInteger statusCode)) failure;

- (void) getUserWithId: (NSString *) user_id
             onSuccess:(void(^)(NSArray *user)) success
             onFailure: (void (^)(NSError *error, NSInteger statusCode)) failure;




@end

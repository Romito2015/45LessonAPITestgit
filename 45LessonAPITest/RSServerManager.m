//
//  RSServerManager.m
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 17.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSServerManager.h"
#import "AFNetworking.h"
#import "RSUser.h"

@interface RSServerManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation RSServerManager

//singleton
+ (RSServerManager *) sharedManager {
    
    static RSServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RSServerManager alloc] init];
    });
    
    return manager;

}

- (id) init {
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void) getFriendsWithOffset:(NSInteger)offset count:(NSInteger)count onSuccess:(void (^)(NSArray *))success onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"6867252",  @"user_id",
                             @"random",   @"order",
                             @(count),    @"count",
                             @(offset),   @"offset",
                             @"photo_50", @"fields",
                             @"nom",      @"name_case", nil];

    [self.requestOperationManager
     GET:@"friends.get"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
         
         NSArray *dictsArray = [responseObject objectForKey:@"response"];
         
         NSMutableArray *objectsArray = [NSMutableArray array];
         
         for (NSDictionary *dict in dictsArray) {
             RSUser *user = [[RSUser alloc] initWithServerResponse:dict];
             [objectsArray addObject:user];
         }
         
         
         if (success) {
             success(objectsArray);
         }
         
    }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
         if (failure) {
             failure(error, operation.response.statusCode);
         }
         
    }];
    
}


@end

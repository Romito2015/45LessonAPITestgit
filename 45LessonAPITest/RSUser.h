//
//  RSUser.h
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 20.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSUser : NSObject

@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL50;
@property (strong, nonatomic) NSURL *imageURL200;

- (id) initWithServerResponse:(NSDictionary *) responseObject;

@end

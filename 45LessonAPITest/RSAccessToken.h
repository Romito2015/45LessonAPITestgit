//
//  RSAccessToken.h
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 22.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAccessToken : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expirationDate;
@property (strong, nonatomic) NSString *userID;

@end

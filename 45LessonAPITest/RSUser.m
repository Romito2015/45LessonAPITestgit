//
//  RSUser.m
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 20.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSUser.h"

@implementation RSUser

- (id) initWithServerResponse:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        
        if ([responseObject objectForKey:@"user_id"]) {
            self.user_id = [responseObject objectForKey:@"user_id"];
            
        } else if ([responseObject objectForKey:@"uid"]) {
            self.user_id = [responseObject objectForKey:@"uid"];
        }
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName  = [responseObject objectForKey:@"last_name"];
        
        NSString *urlString50 = [responseObject objectForKey:@"photo_50"];
        NSString *urlString200 = [responseObject objectForKey:@"photo_200"];
        
        if (urlString50) {
            self.imageURL50 = [NSURL URLWithString:urlString50];
        }
        if (urlString200) {
            self.imageURL200 = [NSURL URLWithString:urlString200];
        }
    }
    return self;
}

@end

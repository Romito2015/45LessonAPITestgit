//
//  RSDetailUser.h
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 20.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDetailUser : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *avatar200;

@property (strong, nonatomic) NSString * userNameString;
@property (strong, nonatomic) NSString *user_id;

- (void) getUserFromServer;

@end

//
//  RSLoginViewController.h
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 22.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSAccessToken;

typedef void(^RSLoginCompletionBlock)(RSAccessToken *token);

@interface RSLoginViewController : UIViewController

- (id) initWithCompletionBlock:(RSLoginCompletionBlock) completionBlock;

@end

//
//  RSDetailUser.m
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 20.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSDetailUser.h"
#import "RSServerManager.h"
#import "RSUser.h"
#import "UIImageView+AFNetworking.h"

@interface RSDetailUser ()
@end

@implementation RSDetailUser

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userName.text = self.userNameString;
    
    [self getUserFromServer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getUserFromServer {
    
    [[RSServerManager sharedManager] getUserWithId:self.user_id onSuccess:^(NSArray *userInArray) {
        //[self.userArray addObjectsFromArray:userInArray];
        for (RSUser * user in userInArray) {
            
                        
       
            UIImage *placeholderImage = [[UIImage alloc] initWithContentsOfFile:@"noUser.png"];
            [self.avatar200 setImageWithURL:user.imageURL200 placeholderImage:placeholderImage];        }
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %d",[error localizedDescription], statusCode);
    }];
  
}

@end

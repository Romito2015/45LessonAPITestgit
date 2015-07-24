//
//  RSViewController.m
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 17.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSViewController.h"
#import "RSServerManager.h"
#import "RSUser.h"
#import "UIImageView+AFNetworking.h"
#import "RSDetailUser.h"

@interface RSViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation RSViewController

static NSInteger friendsInRequest = 20;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendsArray = [NSMutableArray array];
    
    //[self getfrieendsFromServer];
    self.firstTimeAppear =YES;
    
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (self.firstTimeAppear) {
        self.firstTimeAppear = NO;
        [[RSServerManager sharedManager] authorizeUser:^(RSUser *user) {
            
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getfrieendsFromServer {
    
    [[RSServerManager sharedManager]
     getFriendsWithOffset:[self.friendsArray count]
     count:friendsInRequest
     onSuccess:^(NSArray *friends) {
         [self.friendsArray addObjectsFromArray:friends];
         
         //[self.tableView reloadData];
         
         NSMutableArray *newPath = [NSMutableArray array];
         for (int i = (int) [self.friendsArray count] - (int) [friends count]; i < [self.friendsArray count]; i++) {
             [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPath withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
         
         [self.tableView reloadData];
      
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %d",[error localizedDescription], statusCode);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.friendsArray count] + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    static NSString *addCells = @"addCells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    if (indexPath.row == [self.friendsArray count]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addCells];
        cell.textLabel.text = @"Load more";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor grayColor];
        cell.imageView.image = nil;
        
    } else {
        
        RSUser * friend = [self.friendsArray objectAtIndex:indexPath.row];
        
        __weak UITableViewCell *weakCell = cell;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:friend.imageURL50];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
        
        cell.imageView.image = nil;
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.imageView.image = image;
                                           [weakCell layoutSubviews];
                                       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           
                                       }];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.friendsArray count]) {
        [self getfrieendsFromServer];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RSDetailUser *destViewController = segue.destinationViewController;
        if (indexPath.row == [self.friendsArray count]) {
            [destViewController setIsAccessibilityElement:NO];
        } else {
        
        RSUser *userForDetail = [self.friendsArray objectAtIndex:indexPath.row];
        destViewController.userNameString = [NSString stringWithFormat:@"%@ %@ %@",
                                            userForDetail.firstName,
                                            userForDetail.lastName,
                                            userForDetail.user_id];
          
            destViewController.user_id = userForDetail.user_id;
        }
    }
}


@end

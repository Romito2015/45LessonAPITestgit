//
//  RSLoginViewController.m
//  45LessonAPITest
//
//  Created by Roman Chopovenko on 22.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSLoginViewController.h"
#import "RSAccessToken.h"

@interface RSLoginViewController () <UIWebViewDelegate>

@property (copy ,nonatomic) RSLoginCompletionBlock completingBlock;
@property (weak,nonatomic) UIWebView *webView;

@end

@implementation RSLoginViewController

- (id) initWithCompletionBlock:(RSLoginCompletionBlock) completionBlock {
    
    self = [super init];
    if (self) {
        self.completingBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:r];
    
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                          target:self
                                                                          action:@selector(actionCancel:)];
    [self.navigationItem setRightBarButtonItem:item animated:NO];
    self.navigationController.title = @"Login";
    
    NSString *urlString = @"https://oauth.vk.com/authorize?"
                           "client_id=5006556&"
                           "scope=139286&"
                           "redirect_uri=com.yourSpace&"
                           "display=mobile&"
                           "v=5.35&"
                           "response_type=token";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.webView.delegate = nil;
}

#pragma mark - Actions

- (void) actionCancel:(UIBarButtonItem *) item {
    
    if (self.completingBlock) {
        self.completingBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  
    http://com.yourspace/#access_token=0acbefb6454b628c24762c3cc14cbe01ce7a1034ffee1178462560e62db5e298fabb811dea3fb9fda06ad&expires_in=86400&user_id=6867252
    
    
    
    if ([[[request URL] host] isEqualToString:@"com.yourspace"]) {
        
        RSAccessToken *token = [[RSAccessToken alloc] init];
        
        NSString *query = [[request URL] description];
        
        NSArray *array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            NSArray *values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                NSString *key = [values firstObject];
                if ([key isEqualToString:@"access_token"]) {
                    token.token = [values lastObject];
                } else if ([key isEqualToString:@"expires_in"]) {
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                }else if ([key isEqualToString:@"user_id"]) {
                    token.userID = [values lastObject];
                };
                
            }
        }
        
        self.webView.delegate = nil;
        
        if (self.completingBlock) {
            self.completingBlock(token);
        }
        
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
        
        return NO;
    }
    
   // NSLog(@"%@", [request URL]);
    
    return YES;
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

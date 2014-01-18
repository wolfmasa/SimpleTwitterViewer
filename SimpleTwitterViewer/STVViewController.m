//
//  STVViewController.m
//  SimpleTwitterViewer
//
//  Created by 上原 将司 on 2014/01/18.
//  Copyright (c) 2014年 Project Wolf. All rights reserved.
//

#import "STVViewController.h"

@interface STVViewController ()

@end

@implementation STVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tweetTable setDelegate:self];
    [self.tweetTable setDataSource:self];
    
    self.accountStore = [[ACAccountStore alloc]init];
    self.tweets = [NSMutableArray new];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// https://dev.twitter.com/docs/ios/making-api-requests-slrequest
- (IBAction)getTweet:(id)sender
{
    //  Step 0: Check that the user has local Twitter accounts
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        //  Step 1:  Obtain access to the user's Twitter accounts
        ACAccountType *twitterAccountType = [self.accountStore
                                             accountTypeWithAccountTypeIdentifier:
                                             ACAccountTypeIdentifierTwitter];
        [self.accountStore
         requestAccessToAccountsWithType:twitterAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 
                 [self.tweets removeAllObjects];
                 //  Step 2:  Create a request
                 NSArray *twitterAccounts =
                 [self.accountStore accountsWithAccountType:twitterAccountType];
                 NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                               @"/1.1/statuses/user_timeline.json"];
                 NSDictionary *params = @{@"screen_name" : @"wolfmasa",
                                          @"include_rts" : @"0",
                                          @"trim_user" : @"1",
                                          @"count" : @"20"};
                 SLRequest *request =
                 [SLRequest requestForServiceType:SLServiceTypeTwitter
                                    requestMethod:SLRequestMethodGET
                                              URL:url
                                       parameters:params];
                 
                 //  Attach an account to the request
                 [request setAccount:[twitterAccounts lastObject]];
                 
                 //  Step 3:  Execute the request
                 [request performRequestWithHandler:^(NSData *responseData,
                                                      NSHTTPURLResponse *urlResponse,
                                                      NSError *error) {
                     if (responseData) {
                         if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                             NSError *jsonError;
                             // サンプルではDictionaryだけど、Arrayが戻ってきてる
                             // JSONがArrayだし。
                             NSArray *timelineData =
                             [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingAllowFragments error:&jsonError];
                             NSLog(@"class=%@",[timelineData class]);
                             if (timelineData) {
                                 //                                 NSLog(@"Timeline Response: %@\n", timelineData);
                                 for (NSDictionary *dic in timelineData) {
                                     NSLog(@"%@",[dic objectForKey:@"text"]);
                                     [self.tweets addObject:[dic objectForKey:@"text"]];
                                 }
                             }
                             else {
                                 // Our JSON deserialization went awry
                                 NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                             }
                         }
                         else {
                             // The server did not respond successfully... were we rate-limited?
                             NSLog(@"The response status code is %d", urlResponse.statusCode);
                         }
                     }
                 }];
             }
             else {
                 // Access was not granted, or an error occurred
                 NSLog(@"%@", [error localizedDescription]);
             }
         }];
    }
    
    [self.tweetTable reloadData];
}

#pragma mark TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hogehoge"];
    if(indexPath.row+1 <= self.tweets.count)
    {
        NSString *tweet = (NSString*)[self.tweets objectAtIndex:indexPath.row];
        cell.textLabel.text = tweet;
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
        cell.textLabel.numberOfLines = 0;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.tweets objectAtIndex:indexPath.row];
    
//    NSString *storyboardName = NSStringFromClass([STVDetailViewController class]);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    STVDetailViewController *con = [sb instantiateViewControllerWithIdentifier:@"STVDetailViewController"];
    [con setString:title];
    //con.string = [NSString stringWithString:title];

    [self.navigationController pushViewController:con animated:YES];
}

@end

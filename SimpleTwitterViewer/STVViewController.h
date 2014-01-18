//
//  STVViewController.h
//  SimpleTwitterViewer
//
//  Created by 上原 将司 on 2014/01/18.
//  Copyright (c) 2014年 Project Wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "STVDetailViewController.h"

@interface STVViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetTable;

@property (weak, nonatomic) IBOutlet UIButton *getTweetButton;
- (IBAction)getTweet:(id)sender;

@property(strong, nonatomic)ACAccountStore *accountStore;
@property(strong, nonatomic)NSMutableArray *tweets;

@end

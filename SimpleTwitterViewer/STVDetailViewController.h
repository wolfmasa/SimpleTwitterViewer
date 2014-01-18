//
//  STVDetailViewController.h
//  SimpleTwitterViewer
//
//  Created by 上原 将司 on 2014/01/18.
//  Copyright (c) 2014年 Project Wolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STVDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property(retain, nonatomic)NSString *string;

-(void)setString:(NSString*)string;

@end

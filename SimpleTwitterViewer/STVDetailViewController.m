//
//  STVDetailViewController.m
//  SimpleTwitterViewer
//
//  Created by 上原 将司 on 2014/01/18.
//  Copyright (c) 2014年 Project Wolf. All rights reserved.
//

#import "STVDetailViewController.h"

@interface STVDetailViewController ()

@end

@implementation STVDetailViewController

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
}

-(void)viewDidAppear:(BOOL)animated
{
    self.textLabel.text = self.string;
    self.textView.text = self.string;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

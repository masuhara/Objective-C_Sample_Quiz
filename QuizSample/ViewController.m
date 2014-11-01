//
//  ViewController.m
//  QuizSample
//
//  Created by Master on 2014/10/29.
//  Copyright (c) 2014年 net.masuhara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    IBOutlet UIImageView *bgImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [bgImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImage.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end











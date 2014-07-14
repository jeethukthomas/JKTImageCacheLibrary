//
//  ViewController.m
//  JKTImageCacheLibrary-Master
//
//  Created by Jeethu on 14/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    JKT Statements
    _jkt=[[JKTImageCacheLibrary alloc]init];
    [_jkt setPlaceHolder:[UIImage imageNamed:@"image"]];
    [_jkt setImageIn:_image1 withURL:@"http://cdn.wonderfulengineering.com/wp-content/uploads/2013/12/high-definition-wallpaper-3-798x350.jpg"];
    [_jkt setImageIn:_image2 withURL:@"http://www.hdwallpaperscool.com/wp-content/uploads/2013/11/3d-beach-cool-hd-wallpapers-background.jpg"];
    
//
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearCache:(id)sender {
    [_jkt clearCache];
}
@end

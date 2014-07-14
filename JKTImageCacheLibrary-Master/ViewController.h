//
//  ViewController.h
//  JKTImageCacheLibrary-Master
//
//  Created by Jeethu on 14/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTImageCacheLibrary.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) JKTImageCacheLibrary* jkt;
- (IBAction)clearCache:(id)sender;

@end

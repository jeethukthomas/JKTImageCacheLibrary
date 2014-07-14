//
//  JKTImageCacheLibrary.m
//  JKTImageCache
//
//  Created by Jeethu on 10/06/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "JKTImageCacheLibrary.h"
#define TempDir @"JKTtemp"
@implementation JKTImageCacheLibrary
-(id)init
{
    self = [super init];
    
    if (self) {
        [self createTempDirectory];
    }
    
    return self;
}
-(void)getImage:(NSString*)imgUrl withFilename:(NSString*)filename completed:(void (^)(NSString *msg))block;
{
    
    NSString *uniquePath = [self.directoryPath stringByAppendingPathComponent: filename];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        imgUrl=[imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imgUrl]];
        NSLog(@"url %@",[NSURL URLWithString:imgUrl]);
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if ( !error )
                                   {
                                       UIImage *image = [[UIImage alloc] initWithData:data];
                                       if(image)
                                       {
                                       if([imgUrl rangeOfString: @".png" options: NSCaseInsensitiveSearch].location != NSNotFound)
                                       {
                                           [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
                                       }
                                       else if(
                                               [imgUrl rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound ||
                                               [imgUrl rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
                                               )
                                       {
                                           [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
                                       }
                                       
                                       if(block)
                                       {
                                           block(uniquePath);
                                       }
                                       }
                                       else
                                       {
                                           if(block)
                                           {
                                               block(@"Error");
                                           }
                                       }
                                       
                                   } else{
                                       NSLog(@"Hello %@ , %@",response,error);
                                       if(block)
                                       {
                                           block(@"Error");
                                       }
                                   }
                               }];
        
        
        
    }
}
-(void)createTempDirectory
{
    NSError *error = nil;
    NSURL* DirURl=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:TempDir] isDirectory:YES];
    self.directoryPath = [DirURl path] ;
    [[NSFileManager defaultManager] createDirectoryAtURL:DirURl withIntermediateDirectories:YES attributes:nil error:&error];
}

-(void)setImageIn:(UIImageView*)imgView withURL:(NSString*)imgUrl
{
    if(imgUrl)
    {
     
    
    if(_placeHolder)
    imgView.image=_placeHolder;
    [self startRotatingImage:imgView];
    NSString *filename = [[imgUrl stringByReplacingOccurrencesOfString:@"/"
                                                         withString:@"_"] stringByDeletingPathExtension];
    NSString *uniquePath = [self.directoryPath stringByAppendingPathComponent: filename];
    
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        [self stopRotating:imgView];
        imgView.image=[UIImage imageWithContentsOfFile: uniquePath];
    }
    else
    {
        
        [self getImage:imgUrl withFilename:filename completed:^(NSString *path) {
            [self stopRotating:imgView];
            if(![path isEqualToString:@"Error"])
            {
             
            imgView.image=[UIImage imageWithContentsOfFile: path];
            }
        }];
    }
    }
    else
    {
        if(_placeHolder)
            imgView.image=_placeHolder;
    }
}

-(void)clearCache
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.directoryPath error:NULL];
    for (NSString *file in tmpDirectory) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", self.directoryPath, file] error:NULL];
        NSLog(@"path %@",[NSString stringWithFormat:@"%@/%@", self.directoryPath, file]);
    }
}

-(void)startRotatingImage:(UIImageView*)imgV
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.color=[UIColor orangeColor];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(CGRectGetMidX(imgV.bounds), CGRectGetMidY(imgV.bounds));
    activityIndicator.hidesWhenStopped = YES;
    [imgV addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

-(void)stopRotating:(UIImageView*)imgV
{
    for(UIActivityIndicatorView* view in imgV.subviews)
    {
        if([view isKindOfClass:[UIActivityIndicatorView class]])
        {
            [view stopAnimating];
        }
    }
}


@end

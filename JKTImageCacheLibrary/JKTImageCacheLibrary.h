//
//  JKTImageCacheLibrary.h
//  JKTImageCache
//
//  Created by Jeethu on 10/06/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKTImageCacheLibrary : NSObject
@property  (nonatomic,retain)NSString *directoryPath;
@property  (nonatomic,retain)UIImage *placeHolder;
-(void)setImageIn:(UIImageView*)imgView withURL:(NSString*)imgUrl andUserID:userID;
-(void)clearCache;
@end

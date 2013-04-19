//
//  BCImageProcessor.h
//  CoreImageDemo
//
//  Created by Bryan Clark on 3/17/13.
//  Copyright (c) 2013 Bryan Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCImageProcessor : NSObject

+(UIImage *)darkenedImageForImage: (UIImage *)image;
+(UIImage *)blurredImageForImage: (UIImage *)image;
+(UIImage *)darkenedAndBlurredImageForImage: (UIImage *)image;
+(UIImage *)maskImage: (UIImage *)image withMask: (UIImage *)maskImage;


@end

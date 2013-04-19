//
//  BCImageProcessor.m
//  CoreImageDemo
//
//  Created by Bryan Clark on 3/17/13.
//  Copyright (c) 2013 Bryan Clark. All rights reserved.
//

#import "BCImageProcessor.h"

#import <CoreImage/CoreImage.h>

@implementation BCImageProcessor

+ (UIImage *)darkenedImageForImage:(UIImage *)image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //First, create some darkness
    CIFilter *blackGenerator = [CIFilter filterWithName:@"CIConstantColorGenerator"];
    CIColor *black = [CIColor colorWithString:@"0.0 0.0 0.0 0.65"];
    [blackGenerator setValue:black forKey:@"inputColor"];
    CIImage *blackImage = [blackGenerator valueForKey:@"outputImage"];
    
    //Second, apply that black
    CIFilter *compositeFilter = [CIFilter filterWithName:@"CIMultiplyBlendMode"];
    [compositeFilter setValue:blackImage forKey:@"inputImage"];
    [compositeFilter setValue:inputImage forKey:@"inputBackgroundImage"];
    CIImage *darkenedImage = [compositeFilter outputImage];
    
    CGImageRef cgimg = [context createCGImage:darkenedImage fromRect:inputImage.extent];
    UIImage *darkImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    return darkImage;
    
}

+ (UIImage *)blurredImageForImage:(UIImage *)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage: image];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //Blur the image
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setDefaults];
    [blurFilter setValue:@5.0 forKey:@"inputRadius"];
    [blurFilter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *blurredImage = [blurFilter outputImage];
    
    CGImageRef cgimg = [context createCGImage:blurredImage fromRect:inputImage.extent];
    UIImage *blurImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    return blurImage;
    
}

+ (UIImage *)darkenedAndBlurredImageForImage:(UIImage *)image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage: [self darkenedImageForImage:image]];
    
    CIContext *context = [CIContext contextWithOptions:nil];
      
    //Blur the image
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setDefaults];
    [blurFilter setValue:@5.0 forKey:@"inputRadius"];
    [blurFilter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *blurredImage = [blurFilter outputImage];
    
    CGImageRef cgimg = [context createCGImage:blurredImage fromRect:inputImage.extent];
    UIImage *blurredAndDarkenedImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    return blurredAndDarkenedImage;
}


+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
    
}


@end

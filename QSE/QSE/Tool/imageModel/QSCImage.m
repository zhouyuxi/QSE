//
//  QSCImage.m
//  qingsongchou
//
//  Created by zhouyuxi on 16/3/17.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import "QSCImage.h"
#import <MJExtension/MJExtension.h>

@implementation QSCImage

MJCodingImplementation

- (NSString *)image
{
    if (_image.length) {
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)_image, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
        return encodedString;

    }
    return _image;
}


- (NSString *)thumb
{
    if (_thumb.length) {
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)_thumb, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
        return encodedString;
        
    }
    return _thumb;

}
@end

//
//  IWShareTool.m
//  IWShareSDK
//
//  Created by 秦传龙 on 2021/1/13.
//

#import "IWShareTool.h"

@implementation IWShareTool


+ (NSString *)classNameWithOpenURL:(NSURL *)url {
    if ([url.absoluteString hasPrefix:@"ding"]) {
        return @"IWDTPlatform";
    } else if ([url.absoluteString hasPrefix:@"wx"]) {
        return @"IWWxPlatform";
    }
    return @"";
}

+ (UIImage *)URLToUIImage:(NSString *)urlString {
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:NSDataReadingMappedIfSafe error:&error];
    if (!error) {
        return [[UIImage alloc] initWithData:data];
    }
    return nil;
}


@end

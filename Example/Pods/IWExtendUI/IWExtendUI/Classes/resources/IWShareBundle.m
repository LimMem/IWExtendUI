//
//  IWShareBundle.m
//  FBSnapshotTestCase
//
//  Created by 秦传龙 on 2021/1/13.
//

#import "IWShareBundle.h"

@implementation IWShareBundle

+ (instancetype)shareBundle {
    static dispatch_once_t onceToken;
    static IWShareBundle *bundle = nil;
    dispatch_once(&onceToken, ^{
        bundle = [[IWShareBundle alloc] init];
    });
    return bundle;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bundle = [NSBundle bundleForClass:[self class]];
    }
    return self;
}


@end


@implementation NSBundle (iwShare)

+ (NSBundle *)bundle {
    return [IWShareBundle shareBundle].bundle;
}

@end

@implementation UIImage (iwShare)

+ (UIImage *)iwShare_imageNamed:(NSString *)imageNamed {
    NSString *bundlePath = [[NSBundle bundle] bundlePath];
    bundlePath = [bundlePath stringByAppendingPathComponent:@"IWExtendUI.bundle"];
    return [UIImage imageNamed:imageNamed inBundle:[NSBundle bundleWithPath:bundlePath] compatibleWithTraitCollection:nil];
}

@end




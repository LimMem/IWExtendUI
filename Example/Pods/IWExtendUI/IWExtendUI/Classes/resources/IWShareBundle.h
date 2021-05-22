//
//  IWShareBundle.h
//  FBSnapshotTestCase
//
//  Created by 秦传龙 on 2021/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IWShareBundle : NSBundle

+ (instancetype)shareBundle;
@property (nonatomic, strong) NSBundle *bundle;

@end


@interface NSBundle (iwShare)

+ (NSBundle *)bundle;

@end

@interface UIImage (iwShare)

// bundleName值 请参考IWShareSDK.podspec;
+ (UIImage *)iwShare_imageNamed:(NSString *)imageNamed;
@end

NS_ASSUME_NONNULL_END

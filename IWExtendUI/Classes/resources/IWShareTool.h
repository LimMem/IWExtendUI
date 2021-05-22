//
//  IWShareTool.h
//  IWShareSDK
//
//  Created by 秦传龙 on 2021/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IWShareTool : NSObject

+ (NSString *)classNameWithOpenURL:(NSURL *)url;

+ (UIImage *)URLToUIImage:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END

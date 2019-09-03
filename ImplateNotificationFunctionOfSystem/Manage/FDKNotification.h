//
//  FDKNotification.h
//  ImplateNotificationFunctionOfSystem
//
//  Created by MacHD on 2019/8/30.
//  Copyright © 2019 FDK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDKNotification : NSObject<NSCopying, NSCoding>

@property (readonly, copy) NSString *name;
@property (nullable, readonly, weak) id object;
@property (nullable, readonly, copy) NSDictionary *userInfo;

- (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END

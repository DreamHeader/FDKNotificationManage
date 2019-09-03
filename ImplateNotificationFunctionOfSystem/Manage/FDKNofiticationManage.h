//
//  FDKNofiticationManage.h
//  ImplateNotificationFunctionOfSystem
//
//  Created by MacHD on 2019/8/30.
//  Copyright © 2019 FDK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDKNotification;
NS_ASSUME_NONNULL_BEGIN

@interface FDKNofiticationManage : NSObject
/**
 保存观察者对象   name(Key->通知名称) : @[观察者对象]
 */
@property (nonatomic,strong,readonly) NSMutableDictionary * notificationMutableDictionary;
/**
 自定义模仿系统实现通知功能

 @return 返回通知单利对象
 */
+(FDKNofiticationManage *)shareNotification;

#pragma mark - 添加监听对象到观察者中心
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;
//该方法实现有个缺陷：外部对返回值必须强引用，否则返回值会释放，也就无法释放掉这个通知。
- (id<NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(FDKNotification *note))block;
#pragma mark - 发送通知消息
- (void)postNotification:(FDKNotification *)notification;

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

#pragma mark - 移除监听对象
- (void)removeObserver:(id)observer;

- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;

- (void)removeObserverId:(NSString *)observerId;

@end

NS_ASSUME_NONNULL_END

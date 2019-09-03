//
//  FDKNofiticationManage.m
//  ImplateNotificationFunctionOfSystem
//
//  Created by MacHD on 2019/8/30.
//  Copyright © 2019 FDK. All rights reserved.
//

#import "FDKNofiticationManage.h"
#import "FDKNotification.h"
//响应者信息存储模型类
@interface FDKObserverInfoModel : NSObject
@property(weak, nonatomic) id observer;
@property(strong, nonatomic) id observer_strong;
@property(strong, nonatomic) NSString* observerId;
@property(assign, nonatomic) SEL selector;
@property(weak, nonatomic) id object;
@property(copy, nonatomic) NSString* name;
@property(strong, nonatomic) NSOperationQueue* queue;
@property(copy, nonatomic) void (^block)(FDKNotification* noti);
@end
@implementation FDKObserverInfoModel
- (void)dealloc {
  NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}
@end

@interface FDKNofiticationManage ()
@property(nonatomic, strong, readwrite)
    NSMutableDictionary* notificationMutableDictionary;
@end
@implementation FDKNofiticationManage

+ (FDKNofiticationManage*)shareNotification {
  static FDKNofiticationManage* manage = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manage = [[FDKNofiticationManage alloc] init];
    manage.notificationMutableDictionary = [[NSMutableDictionary alloc] init];
  });
  return manage;
}
#pragma mark - Add Obsever
- (void)addObserveInfo:(FDKObserverInfoModel*)infoModel {
  id resultObserver = infoModel.observer ?: infoModel.observer_strong;
  if (!resultObserver) {
    NSLog(@"对象不存在，不添加到通知中心");
    return;
  }
  // key (nofi name ): @[信息]
  NSMutableDictionary* observeDictionary =
      [FDKNofiticationManage shareNotification].notificationMutableDictionary;
  @synchronized(observeDictionary) {
    NSMutableArray* observeInfoArray =
        [observeDictionary objectForKey:infoModel.name];
    if (observeInfoArray) {
      [observeInfoArray addObject:infoModel];
      [observeDictionary setObject:observeInfoArray forKey:infoModel.name];
    } else {
      NSMutableArray* observeMutArray = [[NSMutableArray alloc] init];
      [observeMutArray addObject:infoModel];
      [observeDictionary setObject:observeMutArray forKey:infoModel.name];
    }
  }
}
- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(nullable NSString*)aName
             object:(nullable id)anObject {
  if (!observer || !aSelector) {
    return;
  }
  FDKObserverInfoModel* observeInfoModel = [[FDKObserverInfoModel alloc] init];
  observeInfoModel.observer = observer;
  observeInfoModel.observerId = [NSString stringWithFormat:@"%@", observer];
  observeInfoModel.selector = aSelector;
  observeInfoModel.object = anObject;
  observeInfoModel.name = aName;
  [self addObserveInfo:observeInfoModel];
}

//- (id<NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(FDKNotification *note))block{
//////该方法实现有个缺陷：外部对返回值必须强引用，否则返回值会释放，也就无法释放掉这个通知。
//    return nil;
//}
#pragma mark - Post Notification
- (void)postNotification:(FDKNotification*)notification {
  if (!notification) {
    return;
  }
  NSMutableDictionary* observersDic =
      [FDKNofiticationManage shareNotification].notificationMutableDictionary;
  NSMutableArray* tempArr = [observersDic objectForKey:notification.name];
  if (tempArr && tempArr.count > 0) {
    [tempArr enumerateObjectsUsingBlock:^(FDKObserverInfoModel* _Nonnull obj,
                                          NSUInteger idx, BOOL* _Nonnull stop) {
      if (obj.object == notification.object) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [obj.observer performSelector:obj.selector withObject:notification];
#pragma clang diagnostic pop
      }
    }];
  } else {
    //  ---
  }
}
- (void)postNotificationName:(NSString*)aName object:(nullable id)anObject {
  if (!aName) {
    return;
  }
  FDKNotification* nofi =
      [[FDKNotification alloc] initWithName:aName object:anObject userInfo:nil];
  [self postNotification:nofi];
}

- (void)postNotificationName:(NSString*)aName
                      object:(nullable id)anObject
                    userInfo:(nullable NSDictionary*)aUserInfo {
  if (!aName) {
    return;
  }
  FDKNotification* nofi = [[FDKNotification alloc] initWithName:aName
                                                         object:anObject
                                                       userInfo:aUserInfo];
  [self postNotification:nofi];
}
#pragma mark - remove Notification
- (void)removeObserver:(id)observer{
    
}

- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject{
    
}

- (void)removeObserverId:(NSString *)observerId{
    
    
    
}
@end

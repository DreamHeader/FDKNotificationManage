//
//  FDKNotification.m
//  ImplateNotificationFunctionOfSystem
//
//  Created by MacHD on 2019/8/30.
//  Copyright © 2019 FDK. All rights reserved.
//

#import "FDKNotification.h"
@interface FDKNotification ()
@property(copy) NSString* name;
@property(weak) id object;
@property(copy) NSDictionary* userInfo;
@end

@implementation FDKNotification
- (instancetype)initWithName:(NSString*)name
                      object:(id)object
                    userInfo:(NSDictionary*)userInfo {
  if (!name || ![name isKindOfClass:[NSString class]]) {
    return nil;
  }
  FDKNotification* notifi = [FDKNotification new];
  notifi.name = name;
  notifi.object = object;
  notifi.userInfo = [userInfo copy];
  return notifi;
}
- (id)copyWithZone:(NSZone*)zone {
  FDKNotification* nofi = [[[self class] allocWithZone:zone] init];
  nofi.name = self.name;
  nofi.object = self.object;
  nofi.userInfo = self.userInfo;
  return nofi;
}
- (void)encodeWithCoder:(NSCoder*)aCoder {
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.object forKey:@"object"];
  [aCoder encodeObject:self.userInfo forKey:@"userInfo"];
}
- (instancetype)initWithCoder:(NSCoder*)aDecoder {
  if (self = [super init]) {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.object = [aDecoder decodeObjectForKey:@"object"];
    self.userInfo = [aDecoder decodeObjectForKey:@"userInfo"];
  }
  return self;
}

@end

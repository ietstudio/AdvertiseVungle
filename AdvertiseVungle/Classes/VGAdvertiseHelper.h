//
//  VGAdvertiseHelper.h
//  Pods
//
//  Created by geekgy on 16/6/5.
//
//

#import <Foundation/Foundation.h>
#import "AdvertiseDelegate.h"
#import "Macros.h"

#define Vungle_Name             @"Vungle"
#define Vungle_AppId            @"Vungle_AppId"

@interface VGAdvertiseHelper : NSObject <AdvertiseDelegate>

SINGLETON_DECLARE(VGAdvertiseHelper)

@end


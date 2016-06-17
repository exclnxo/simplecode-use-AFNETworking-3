//
//  MyManager.h
//  Example
//
//  Created by 徐常璿 on 2016/6/14.
//  Copyright © 2016年 Eric Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject
@property (nonatomic,strong)NSArray* member;
+(id)sharedManager;
@end

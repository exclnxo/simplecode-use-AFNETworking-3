//
//  MyManager.m
//  Example
//
//  Created by 徐常璿 on 2016/6/14.
//  Copyright © 2016年 Eric Hsu. All rights reserved.
//

#import "MyManager.h"

@implementation MyManager
@synthesize member;
+(id)sharedManager{
    static MyManager *sharedMyManager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedMyManager =[self new];
    });
    return sharedMyManager;
}
-(id)init{
    if(self = [super init]){
        member = [NSArray new];
    }
    return self;
}

@end

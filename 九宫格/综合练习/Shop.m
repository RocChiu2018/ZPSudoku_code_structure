//
//  Shop.m
//  综合练习
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Shop.h"

@implementation Shop

/**
 实例方法里面的self代表本类的一个对象实例
 */
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.name = [dict valueForKey:@"name"];
        self.icon = [dict valueForKey:@"icon"];
    }
    
    return self;
}

/**
 类方法里面的self代表本类
 */
+(instancetype)shopWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end

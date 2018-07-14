//
//  Shop.h
//  综合练习
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 此类为MVC分层结构中的Model层（对象层）；
 Model层的作用是提供对象的封装方法，便于在Controller层里面封装对象。
 */
#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (nonatomic, strong) NSString *name;  //商品名称
@property (nonatomic, strong) NSString *icon;  //商品图标

/**
 instancetype在类型表示上，跟id一样，可以表示任何对象类型；
 instancetype只能用在返回值类型上，不能像id一样用在参数类型上；
 instancetype比id多了一个好处：编译器会检测instancetype的真实类型。比如：调用类方法返回的应该是一个Shop对象类型，但是用了一个其他类型的对象来接收，编译器就会发出警告；
 Model类里面的封装方法一般写两个，一个是实例方法，一个是类方法，便于开发人员进行调用；
 一般手写的封装对象的方法从封装的速度来讲会快于其他的第三方的封装方法。
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)shopWithDict:(NSDictionary *)dict;

@end

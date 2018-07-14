//
//  XMGShopView.h
//  03-综合使用
//
//  Created by xiaomage on 15/5/26.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

/**
 此类为自定义控件类，属于MVC分层结构中的View层；
 本Demo中用代码的方式构造此自定义控件类，另有Demo介绍如何用xib的方式构造此自定义控件类；
 View层的作用是接收Controller层传过来的对象(Model)，并把对象里面的数据呈现出来。
 */
#import <UIKit/UIKit.h>

@class Shop;

@interface ZPShopView : UIView

@property (nonatomic, strong) Shop *shop;  //商品对象

@end

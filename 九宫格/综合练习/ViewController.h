//
//  ViewController.h
//  综合练习
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 此类为MVC分层结构中的Controller层；
 Controller层的作用是在本类中获取后台传过来的json数据，并且把数据封装成对象，在恰当的时候把相应的对象传给视图层(View)，视图层再根据传过来的对象把数据呈现出来，所以Controller层起到了连接Model层和View层的承上启下的作用。
 */
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@end

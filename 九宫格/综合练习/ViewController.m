//
//  ViewController.m
//  综合练习
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 UIButton内部包含图片和文字，默认情况下图片在左侧，文字在右侧，但是可以调整图片和文字的位置；
 在xib中既能设置UIButton的Image又能设置Background，两者的区别就是Image是指按钮内部的左侧图片，Background是指按钮整个的背景图片；
 在xib中按钮的type选为System的时候，不管高亮状态是否设置了图片，按下去的时候都会呈现灰色，要想在高亮状态呈现原来设置的图片，就要把type选为Custom；
 xib中两个或多个按钮触发代码中的同一个方法是可以的，但是在xib连线的时候要把按钮传过来，在代码中再根据按钮设置的tag来判断用户点击的到底是哪个按钮。
 */
#import "ViewController.h"
#import "Shop.h"
#import "ZPShopView.h"

@interface ViewController ()

// 单行注释
/* 多行注释 */
/** 文档注释 */
@property (weak, nonatomic) IBOutlet UIView *shopsView;
@property (strong, nonatomic) NSArray *shopsArray;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UILabel *hud;

@end

@implementation ViewController

#pragma mark ————— 懒加载 —————
/**
 有的时候用户可能在某个页面中一直在做其他的操作，可能一直也不会用到此页面上的数据，所以一上来就在viewDidLoad方法中加载那些数据是多余的，因为有可能一直也不会用到，而且会占用内存空间，数据量比较少的时候还可以，如果数据量比较大的话会比较耗费系统的资源，所以一般在用户真正用到数据的时候才加载了，并且只会加载一次，这种用到数据的时候才加载并且只会加载一次，而不是一开始就加载的方式叫做懒加载；
 一般通过重写变量的get方法来完成懒加载。
 */
-(NSArray *)shopsArray
{
    if (_shopsArray == nil)
    {
        /**
         获取plist文件的全路径；
         可以在pathForResource:后面写文件的全名@"shops.plist"，在ofType:后面写nil；
         如果不写成上述的样子的话，也可以在pathForResource:后面写@"shops"，在ofType:后面写@"plist"；
         上述的两种书写方式都能获取到plist文件的全路径。
         */
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];  //凡是方法名带“File”的，后面的参数都要写文件的全路径
        
        //封装对象
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray)
        {
            Shop *shop = [Shop shopWithDict:dict];  //将字典转换成模型
            [tempArray addObject:shop];
        }
        
        _shopsArray = tempArray;
    }
    
    return _shopsArray;
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     把具有相同作用的并且存在大量重复代码的部分抽出来，把不同的部分作为参数，写成一个方法，从而可以有效地减少冗余代码，提高程序的运行效率。
     */
    
    //创建添加按钮
    self.addButton = [self addButtonWithImage:@"add" highlightedImage:@"add_highlighted" disabledImage:@"add_disabled" frame:CGRectMake(30, 80, 50, 50) action:@selector(add)];
    
    //创建删除按钮
    self.removeButton = [self addButtonWithImage:@"remove" highlightedImage:@"remove_highlighted" disabledImage:@"remove_disabled" frame:CGRectMake(270, 80, 50, 50) action:@selector(remove)];
    
    //一开始不能使用删除按钮
    self.removeButton.enabled = NO;
}

#pragma mark ————— 创建按钮 —————
-(UIButton *)addButtonWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage disabledImage:(NSString *)disabledImage frame:(CGRect)frame action:(SEL)action
{
    /**
     在代码中要想给按钮设置高亮状态下的背景图片就要在创建按钮的时候把按钮的Type设置为Custom，如果设置为System的话则在该状态下，按钮高亮的时候会呈现灰色。
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIButton *button = [[UIButton alloc] init];  //这句代码与上句的作用相同，用init方法创建的时候会把按钮的type默认设置为Custom
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:disabledImage] forState:UIControlStateDisabled];
    button.frame = frame;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    return button;
}

#pragma mark ————— 点击添加按钮 —————
-(void)add
{
    //使超过视图部分的控件不显示出来
    self.shopsView.clipsToBounds = YES;
    
    //每一个商品的尺寸
    CGFloat shopW = 40;
    CGFloat shopH = 60;
    
    //每一行的列数
    int cols = 3;
    
    //每一列之间的间距
    CGFloat colMargin = (self.shopsView.frame.size.width - cols * shopW) / (cols - 1);
    //每一行之间的间距
    CGFloat rowMargin = 10;
    
    //创建一个父控件，用于存放图片和文字
    ZPShopView *shopView = [[ZPShopView alloc] init];
    
    //商品的索引
    NSUInteger index = self.shopsView.subviews.count;
    
    //向ZPShopView类传递对象
    shopView.shop = [self.shopsArray objectAtIndex:index];
    
    //获取商品所在的列数（取余数）
    NSUInteger col = index % cols;
    
    //商品的x值
    CGFloat shopX = col * (shopW + colMargin);
    
    //商品所在的行数（取商）
    NSUInteger row = index / cols;
    
    //商品的y值
    CGFloat shopY = row * (shopH + rowMargin);
    
    //商品的frame
    shopView.frame = CGRectMake(shopX, shopY, shopW, shopH);
    
    [self.shopsView addSubview:shopView];
    
    [self checkState];
}

#pragma mark ————— 点击删除按钮 —————
-(void)remove
{
    [self.shopsView.subviews.lastObject removeFromSuperview];
    
    [self checkState];
}

#pragma mark ————— 检测按钮的状态 —————
-(void)checkState
{
    if (self.shopsView.subviews.count == 0)
    {
        self.addButton.enabled = YES;
        self.removeButton.enabled = NO;
    }else if (self.shopsView.subviews.count > 0 && self.shopsView.subviews.count < self.shopsArray.count)
    {
        self.addButton.enabled = YES;
        self.removeButton.enabled = YES;
    }else if (self.shopsView.subviews.count == self.shopsArray.count)
    {
        self.addButton.enabled = NO;
        self.removeButton.enabled = YES;
    }
    
    /**
     HUD的背景一般是半透明的，但是如果设置HUD的alpha为0.5的话，则HUD上面的文字也会变成半透明的，这样的效果不好，所以一般在xib上点击HUD的Background，然后再点击下拉菜单里面的Other，选择Opacity为50%，这样才能做到HUD的背景是半透明的，但HUD上面的文字不是半透明的的效果。
     */
    NSString *text = nil;
    if (self.removeButton.enabled == NO)
    {
        text = @"已经全部删除了";
    }else if(self.addButton.enabled == NO)
    {
        text = @"已经添加满了";
    }
    
    if (text)
    {
        self.hud.alpha = 1.0;
        self.hud.text = text;
        
        /**
         时间延长方法1：两秒钟后调用@selector方法并传入参数@"123"；
         withObject:后面的是需要传给@selector方法的参数。
         */
        [self performSelector:@selector(hideHud:) withObject:@"123" afterDelay:2.0];
        
        /**
         时间延长方法2：两秒钟后执行block里面的代码。
         */
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.hud.alpha = 0.0;
//        });
        
        /**
         时间延长方法3：两秒钟后调用@selector方法；
         userInfo:后面的参数不是给@selector方法传递的参数。
         */
//        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideHud:) userInfo:@"hello" repeats:NO];
    }else
    {
        return;
    }
}

#pragma mark ————— 隐藏提示框 —————
-(void)hideHud:(NSString *)parameter
{
    self.hud.alpha = 0.0;
    
    NSLog(@"parameter = %@", parameter);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

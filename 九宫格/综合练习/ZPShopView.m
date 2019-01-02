//
//  XMGShopView.m
//  03-综合使用
//
//  Created by xiaomage on 15/5/26.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

/**
 自定义控件的封装：
 如果一个View内部的子控件比较多，一般会考虑自定义一个View，把它内部子控件的创建屏蔽起来，不让外界关心；
 外界可以传入对应的模型数据给这个自定义View，这个自定义View拿到模型数据后给内部的子控件设置对应的数据。
 
 创建自定义控件分为用代码创建和用xib创建两种方式，每种创建方式调用的方法会有不同：
 1、用代码创建：首先会调用initWithFrame方法，一般在此方法中会创建此自定义控件内的子控件（不设置尺寸）并做一些初始化的工作。然后会调用layoutSubviews方法，在此方法中设置此自定义控件内的子控件的尺寸。接着会调用drawRect方法，一般会在此方法中做一些子控件的初始化工作。这种用代码创建自定义控件的方式不会调用initWithCoder和awakeFromNib方法；
 2、用xib创建：首先会调用initWithCoder方法，但是在此方法中不能使用连线的属性（子控件），因此在此方法中不能做任何事情。然后会调用awakeFromNib方法，在此方法中可以使用连线的属性（子控件）了，一般在此方法中做一些子控件的初始化工作，但不设置子控件的尺寸。接着会调用layoutSubviews方法，一般在此方法中设置子控件的尺寸。最后会调用drawRect方法，一般在此方法中做一些子控件的初始化工作。这种用xib创建的方式不会调用initWithFrame方法；
 一般还会在自定义控件类的内部撰写一个协议，暴露给其他类，方便从本自定义控件类给其他类传递数据。
 
 自定义cell的封装和上述的自定义控件的封装略有区别：
 1、用代码自定义：在自定义cell类(ZPTableViewCell)中的initWithStyle:reuseIdentifier:方法中创建自定义cell里面的子控件，然后在此类中的layoutSubviews方法中设置这些子控件的尺寸即可；
 2、用xib自定义：在自定义cell类(ZPTableViewCell)中的cellWithTableView方法中加载自定义cell的xib文件即可。
 */
#import "ZPShopView.h"
#import "Shop.h"

@interface ZPShopView()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ZPShopView

#pragma mark ————— 懒加载 —————
//- (UIImageView *)iconView
//{
//    if (_iconView == nil)
//    {
//        _iconView = [[UIImageView alloc] init];
//        _iconView.backgroundColor = [UIColor blueColor];
//        [self addSubview:_iconView];
//    }
//
//    return _iconView;
//}

//- (UILabel *)nameLabel
//{
//    if (_nameLabel == nil)
//    {
//        _nameLabel = [[UILabel alloc] init];
//        _nameLabel.font = [UIFont systemFontOfSize:11];
//        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.backgroundColor = [UIColor redColor];
//        [self addSubview:_nameLabel];
//    }
//
//    return _nameLabel;
//}

#pragma mark ————— 创建自定义控件内的子控件 —————
/**
 其他类用代码创建这个自定义控件的时候会调用这个方法，但是用xib创建的时候就不会调用这个方法；
 因为init方法内部会自动调用initWithFrame方法，所以当其他类用init方法创建这个自定义控件的时候系统会自动调用initWithFrame方法；
 一般在此方法内创建这个自定义控件内的子控件，但不设置子控件的尺寸。也可以不在此方法内创建此自定义控件内的子控件，把创建子控件的代码写成懒加载的方式，等用到的时候再去创建。
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor orangeColor];
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.iconView];

        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:11];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.nameLabel];
        
        NSLog(@"initWithFrame");
    }
    
    return self;
}

/**
 用xib创建这个自定义控件的时候就会调用此方法，但是用代码创建的时候就不会调用此方法；
 xib从文件中解析完毕的时候会调用这个方法进行初始化，当初始化完成以后会进行IBOutlet属性的连线，连完线以后才会调用awakeFromNib方法了，所以在此方法中还不能使用连线的属性，此时连线的属性还为nil了，所以一般在此方法中什么也做不了。
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        NSLog(@"initWithCoder");
    }
    
    return self;
}

/**
 用xib创建这个自定义控件的时候，系统会先调用initWithCoder方法，然后才会调用此方法，但是用代码创建的时候则不会调用此方法；
 因为在此方法中可以使用IBOutlet连线的属性了，所以一般在此方法中对这些连线的属性做一些初始化的工作，比如把方形的头像变成圆形的等等诸如此类的操作。
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    NSLog(@"awakeFromNib");
}

#pragma mark ————— 设置自定义控件内的子控件的尺寸 —————
/**
 不论用代码创建还是用xib创建此自定义控件，系统都会调用此方法，一般在此方法中设置自定义控件内部的子控件的尺寸；
 当设置这个自定义控件本身的尺寸或者这个自定义控件本身的尺寸发生改变的时候，系统会自动调用这个方法，在该方法里面设置子控件的尺寸。在此例中因为在ViewController类里面设置了这个自定义控件的尺寸(shopView.frame = CGRectMake(shopX, shopY, shopW, shopH);)，所以系统才会自动调用这个方法；
 如果自定义控件类里有属于自己类的布局子控件尺寸的方法的话，就要在相应的方法里面布局子控件的尺寸，不要在此方法里面布局子控件的尺寸了，因为如果在此方法里布局子控件的尺寸的话就会擦除本类中原来固有布局子控件尺寸的方法里面的代码。比如自定义了一个按钮（父类是UIButton），本来UIButton类里就有布局按钮里面的图片和文字的方法imageRectForContentRect和titleRectForContentRect，直接在上述的两个方法里面重新布局图片和文字的位置就好了，就不必在此方法中布局按钮的图片和文字了的位置了；
 此方法在消息循环结束的时候调用。
 */
- (void)layoutSubviews
{
    //一定要调用super的layoutSubviews方法
    [super layoutSubviews];
    
    CGFloat shopW = self.frame.size.width;
    CGFloat shopH = self.frame.size.height;
    self.iconView.frame = CGRectMake(0, 0, shopW, shopW);
    self.nameLabel.frame = CGRectMake(0, shopW, shopW, shopH - shopW);
    
    NSLog(@"layoutSubviews");
}

/**
 当自定义控件显示到屏幕上时，系统就会自动调用此方法进行绘制；
 不论用代码创建还是用xib创建此自定义控件，系统都会调用此方法。和awakeFromNib方法的作用相似，一般在此方法中做一些子控件的初始化工作，比如把方形的头像变成圆形的等等诸如此类的操作。
 */
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSLog(@"drawRect");
}

#pragma mark ————— 设置数据 —————
/**
 通过set方法给自定义控件设置数据
 */
- (void)setShop:(Shop *)shop
{
    //把数据交给属性保存，方便以后调用get方法的时候使用
    _shop = shop;
    
    self.nameLabel.text = shop.name;
    
    /**
     如果图片名称是nil的话则运行之后控制台会打印"CUICatalog: Invalid asset name supplied: '(null)'"语句，要避免这个问题的发生就要先判断图片名称是否存在，再赋值给UIImageView控件。
     */
    if (shop.icon)
    {
        self.iconView.image = [UIImage imageNamed:shop.icon];
    }
}

@end

//
//  ViewController.m
//  browser1
//
//  Created by 极客学院 on 16/3/2.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import "ViewController.h"
#import "singerModel.h"

@interface ViewController ()

// 保存plist文件里读出来的所有模型
@property(nonatomic,strong)NSMutableArray*arrayAll;

// 显示歌手名称的label
@property(nonatomic,strong)UILabel*titleL;

// 显示歌手图片的UIImageView
@property(nonatomic,strong)UIImageView*imgView;

// 上一张按钮
@property(nonatomic,strong)UIButton*btnBack;

// 下一张按钮
@property(nonatomic,strong)UIButton*btnNext;

// 当前是那一张
@property(nonatomic,assign)int iIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取出第一个元素
    singerModel*model = self.arrayAll[0];
    
    
    // 创建标题label
    UILabel*titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 90, 200, 30)];
    
    titleLabel.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:titleLabel];
    
    self.titleL = titleLabel;
    
    // 显示歌手名称
    NSString*strTitle = [NSString stringWithFormat:@"%@ %d/%d",model.name,1,self.arrayAll.count];
    titleLabel.text = strTitle;
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    // 创建UIImageView
    UIImageView*imgView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 120, 200, 200)];
    
    imgView.backgroundColor = [UIColor redColor];
    
    imgView.center = self.view.center;
    
    [self.view addSubview:imgView];
    
    self.imgView = imgView;
    
    imgView.image = [UIImage imageNamed:model.pic];
    
    // 添加上一张按钮
    UIButton*btnBack = [[UIButton alloc]initWithFrame:CGRectMake(60, 360, 100, 40)];
    btnBack.backgroundColor = [UIColor grayColor];
    [btnBack setTitle:@"上一张" forState:UIControlStateNormal];
    
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnBack];
    
    self.btnBack = btnBack;
    
    // 添加下一张按钮
    UIButton*btnNext = [[UIButton alloc]initWithFrame:CGRectMake(180, 360, 100, 40)];
    btnNext.backgroundColor = [UIColor grayColor];
    [btnNext setTitle:@"下一张" forState:UIControlStateNormal];
    
    [btnNext addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnNext];
    
    self.btnNext = btnNext;
    
    
}

#pragma mark 上一张
-(void)back
{
    if (self.iIndex > 0) {
        self.iIndex--;
        
        singerModel*model = self.arrayAll[self.iIndex];
        
        NSString*strTitle = [NSString stringWithFormat:@"%@ %d/%d",model.name,self.iIndex +1,self.arrayAll.count];
        self.titleL.text = strTitle;
        
        self.imgView.image = [UIImage imageNamed:model.pic];
    }
    
}

#pragma mark 下一张
-(void)next
{
    if (self.iIndex < self.arrayAll.count - 1)
    {
        // 翻下一页
        self.iIndex++;
        
        singerModel*model = self.arrayAll[self.iIndex];
        
        NSString*strTitle = [NSString stringWithFormat:@"%@ %d/%d",model.name,self.iIndex +1,self.arrayAll.count];
        self.titleL.text = strTitle;
        
        self.imgView.image = [UIImage imageNamed:model.pic];

    }
}

// 懒加载
-(NSMutableArray*)arrayAll
{
    if (!_arrayAll) {
        // 初始化
        _arrayAll = [NSMutableArray array];
        
        NSString*strPath = [[NSBundle mainBundle]pathForResource:@"picList.plist" ofType:nil];
        
        NSArray*array = [NSArray arrayWithContentsOfFile:strPath];
        
        for (NSDictionary*dict in array) {
            singerModel*model = [singerModel singerModelWithDict:dict];
            
            [_arrayAll addObject:model];
        }
        
    }
    
    return _arrayAll;
}



@end

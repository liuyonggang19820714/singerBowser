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

#pragma mark 创建标题label懒加载
-(UILabel*)titleL
{
    if (_titleL == nil) {
        // 创建标题label
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(60, 90, 200, 30)];
        
        _titleL.backgroundColor = [UIColor redColor];
        
        _titleL.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleL];
    }
    
    return _titleL;
}

#pragma mark 创建UIImageView懒加载
-(UIImageView*)imgView
{
    if (!_imgView) {
        // 创建UIImageView
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 120, 200, 200)];
        
        _imgView.backgroundColor = [UIColor redColor];
        
        _imgView.center = self.view.center;
        
        [self.view addSubview:_imgView];

    }
    
    return _imgView;
}

#pragma mark 创建上一张按钮懒加载
-(UIButton*)btnBack
{
    if (!_btnBack) {
        // 添加上一张按钮
        _btnBack = [[UIButton alloc]initWithFrame:CGRectMake(60, 360, 100, 40)];
        _btnBack.backgroundColor = [UIColor blueColor];
        [_btnBack setTitle:@"上一张" forState:UIControlStateNormal];
        
        [_btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_btnBack];

    }
    return _btnBack;
}

#pragma mark 创建下一张按钮懒加载
-(UIButton*)btnNext
{
    if (!_btnNext) {
        // 添加下一张按钮
        _btnNext = [[UIButton alloc]initWithFrame:CGRectMake(180, 360, 100, 40)];
        _btnNext.backgroundColor = [UIColor blueColor];
        [_btnNext setTitle:@"下一张" forState:UIControlStateNormal];
        
        [_btnNext addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_btnNext];
    }
    
    return _btnNext;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCurentPage:0];
    
}

#pragma mark 上一张
-(void)back
{
    if (self.iIndex > 0) {
        self.iIndex--;
        
        [self showCurentPage:self.iIndex];
    }
    
}

#pragma mark 下一张
-(void)next
{
    if (self.iIndex < self.arrayAll.count - 1)
    {
        // 翻下一页
        self.iIndex++;
        
        [self showCurentPage:self.iIndex];
    }
}

#pragma mark 显示当前页
-(void)showCurentPage:(int) iPage
{
    if (iPage>= 0 || iPage< self.arrayAll.count) {
        
        singerModel*model = self.arrayAll[iPage];
        
        NSString*strTitle = [NSString stringWithFormat:@"%@ %d/%d",model.name,iPage +1,self.arrayAll.count];
        self.titleL.text = strTitle;
        
        self.imgView.image = [UIImage imageNamed:model.pic];
        
        // 如果当前显示的是第一张，前一站按钮不可用
        if (iPage == 0) {
            self.btnBack.enabled = NO;
            self.btnBack.backgroundColor = [UIColor grayColor];
        }
        else
        {
            self.btnBack.enabled = YES;
            self.btnBack.backgroundColor = [UIColor blueColor];
        }
        
        if(iPage == self.arrayAll.count - 1)
        {
            self.btnNext.enabled = NO;
            self.btnNext.backgroundColor = [UIColor grayColor];
        }
        else
        {
            self.btnNext.enabled = YES;
            self.btnNext.backgroundColor = [UIColor blueColor];
        }
        
        

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

//
//  singerModel.m
//  browser1
//
//  Created by 极客学院 on 16/3/2.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import "singerModel.h"

@implementation singerModel


-(instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        
        // 使用kvc
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)singerModelWithDict:(NSDictionary*)dict
{
    return [[singerModel alloc]initWithDict:dict];
}

@end

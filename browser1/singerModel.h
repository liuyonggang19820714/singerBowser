//
//  singerModel.h
//  browser1
//
//  Created by 极客学院 on 16/3/2.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface singerModel : NSObject

// 歌手
@property(nonatomic,copy)NSString*name;

// 歌曲
@property(nonatomic,copy)NSString*songname;

// 图片文件名
@property(nonatomic,copy)NSString*pic;

-(instancetype)initWithDict:(NSDictionary*)dict;

+(instancetype)singerModelWithDict:(NSDictionary*)dict;

@end

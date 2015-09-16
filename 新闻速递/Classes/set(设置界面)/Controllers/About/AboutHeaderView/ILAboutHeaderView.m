//
//  ILAboutHeaderView.m
//  01-ItcastLottery
//
//  Created by yz on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILAboutHeaderView.h"

@implementation ILAboutHeaderView

#warning TODO ICON

+ (instancetype)headerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ILAboutHeaderView" owner:nil options:nil][0];
}
@end

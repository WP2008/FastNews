//
//  WPSettingCell.m
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "WPSettingCell.h"
#import "WPSettingArrowItem.h"
#import "WPSettingLabelItem.h"
#import "WPSettingSwitchItem.h"

@interface WPSettingCell()
// cell 中可能有的控件
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation WPSettingCell

- (void)awakeFromNib {
    // Initialization code   xib 实例完成后调用
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UISwitch *)switchView {
    if ( _switchView == nil) {
        _switchView = [[UISwitch alloc]init];
    }
    return _switchView;
}

- (UILabel *)label {
    if ( _label == nil) {
        _label = [UILabel new];
        _label.frame = CGRectMake(0, 0, 100, 44);
        _label.textColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentRight;
    }
    return _label;
}


- (void)setItem:(WPSettingItem *)item {
    _item = item;
    // 设置数据
    [self setUpData];
    // 设置cell的详情view
   [self setUpAccessoryView];

}

/**
 *  设置data
 */
- (void)setUpData {
    self.textLabel.text = _item.title;
    if (_item.icon != nil) {
        self .imageView.image = [UIImage imageNamed:_item.icon];
    }
    
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    
}


/**
 *  设置右边的状态
 */
- (void)setUpAccessoryView {
    
    if ([_item isKindOfClass:[WPSettingArrowItem class]]) {
        // 箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }
    else if ([_item isKindOfClass:[WPSettingSwitchItem class]]) {
        // switch
        self.accessoryView = self.switchView ;
        // switch 不能选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else if([_item isKindOfClass:[WPSettingLabelItem class]]) {
        self.accessoryView = self.label;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        WPSettingLabelItem *labelItem = (WPSettingLabelItem *)_item;
        self.label.text = labelItem.text;
        
    }
    else {
        
        self.accessoryView  = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }
    
    
}



/**
 *  创建cell 或在缓存池中取得
 *
 *  @param tableView cell 所在的tableView
 *
 *  @return cell 的实例
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"Cell";
    
    WPSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WPSettingCell alloc]initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:ID];
    }
    
    return cell;
    
}


/**
 *  ios6 中的适配
 */
//- (void)setFrame:(CGRect)frame {
//    frame.size.width += 20;
//    frame.origin.x -= 10;
//    [super setFrame:frame];
//}

@end

//
//  NewsCTableViewCell.h
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/11/23.
//  Copyright © 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommInfo.h"

@interface NewsCTableViewCell : UITableViewCell
-(void)refreshCell:(NewsInfo*)info;

@end

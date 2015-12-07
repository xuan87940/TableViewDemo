//
//  TableViewController.h
//  TableViewDemo
//
//  Created by YaSheng on 2015/9/15.
//  Copyright (c) 2015年 YaSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController
{
    NSString *index1;
    NSInteger count;
}

@property (strong, nonatomic) IBOutlet UITableView *tableviewlist;

@end

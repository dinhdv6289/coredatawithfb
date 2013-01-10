//
//  ListFriendFBViewController.h
//  HelloFB
//
//  Created by Duong Van Dinh on 1/7/13.
//  Copyright (c) 2013 Duong Van Dinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCD.h"
@interface ListFriendFBViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *dataTable;
    IBOutlet UITableView *tableView;
    FriendCD *friendCD;
}
@property (nonatomic,retain) NSMutableArray *dataTable;
@property (nonatomic,retain) UITableView *tableView;
@end

//
//  XWBaseViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/28.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWBaseViewModel : NSObject<UITableViewDataSource, UICollectionViewDataSource>

@property (nullable, nonatomic, readonly) NSArray *data;

- (void)xw_configTableviewCell:(UITableViewCell*(^)(UITableView *tableView, NSIndexPath *indexPath))cellConfig;
- (void)xw_configCollectionViewCell:(UICollectionViewCell*(^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellConfig;

@end

NS_ASSUME_NONNULL_END

//
//  XWBaseViewModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/28.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWBaseViewModel.h"

@interface XWBaseViewModel ()


@property (nonatomic, strong,readwrite) NSArray *data;
@property (nonatomic, copy) UITableViewCell*(^tableviewCellConfig)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) UICollectionViewCell*(^collectionViewCellConfig)(UICollectionView *collectionView, NSIndexPath *indexPath);

@end

@implementation XWBaseViewModel

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

#pragma mark - <UITableViewDataSource>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableviewCellConfig) {
        return _tableviewCellConfig(tableView, indexPath);
    };
    return nil;
}

- (void)xw_configTableviewCell:(UITableViewCell * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))cellConfig {
    _tableviewCellConfig = cellConfig;
}

- (void)xw_configCollectionViewCell:(UICollectionViewCell * _Nonnull (^)(UICollectionView * _Nonnull, NSIndexPath * _Nonnull))cellConfig {
    _collectionViewCellConfig = cellConfig;
}

#pragma mark - <UICollectionViewDataSouce>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_collectionViewCellConfig) {
        return _collectionViewCellConfig(collectionView, indexPath);
    }
    return nil;
}

@end

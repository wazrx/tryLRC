
//
//  XWSearchResultCell.m
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchResultCell.h"
#import "XWSearchResultModel.h"
#import "XWCatergory.h"
#import <Masonry.h>

static NSString *XWSearchResultCellIdentifier = @"XWSearchResultCellIdentifier";

@implementation XWSearchResultCell{
    UILabel *_songNameLabel;
    UILabel *_artistLabel;
    UILabel *_composerLabel;
    UILabel *_lrcFirstLineLabel;
}

+ (instancetype)xw_cellWithTableView:(UITableView *)tableView {
    XWSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:XWSearchResultCellIdentifier];
    if (!cell) {
        cell = [[XWSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XWSearchResultCellIdentifier];
        [cell _xw_initailizeUI];
    }
    return cell;
}

#pragma mark - initialize methods

- (void)_xw_initailizeUI{
    self.backgroundColor = XWhiteC;
    UILabel *songNameLabel = [UILabel new];
    _songNameLabel = songNameLabel;
    songNameLabel.font = XFont(14);
    songNameLabel.numberOfLines = 0;
    songNameLabel.textColor = XSkyBlueC;
    [self.contentView addSubview:songNameLabel];
    [songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(widthRatio(10));
        make.top.equalTo(self).offset(widthRatio(2.5));
    }];
    
    UILabel *artistLabel = [UILabel new];
    _artistLabel = artistLabel;
    artistLabel.font = XFont(12);
    artistLabel.textColor = XSkyBlueC;
    [self.contentView addSubview:artistLabel];
    [artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(songNameLabel);
        make.top.equalTo(songNameLabel.mas_bottom).offset(widthRatio(2.5));
    }];
    
    UILabel *composerLabel = [UILabel new];
    _composerLabel = composerLabel;
    composerLabel.font = XFont(12);
    composerLabel.textColor = XSkyBlueC;
    [self.contentView addSubview:composerLabel];
    [composerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(songNameLabel);
        make.top.equalTo(artistLabel.mas_bottom).offset(widthRatio(2.5));
    }];
    
    UILabel *lrcFirstLineLabel = [UILabel new];
    _lrcFirstLineLabel = lrcFirstLineLabel;
    lrcFirstLineLabel.font = XFont(11);
    lrcFirstLineLabel.textColor = XSkyBlueC;
    [self.contentView addSubview:lrcFirstLineLabel];
    [lrcFirstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(songNameLabel);
        make.top.equalTo(composerLabel.mas_bottom).offset(widthRatio(2.5));
    }];
}

- (void)setData:(XWSearchResultModel *)data{
    _data = data;
    _songNameLabel.text = data.songName;
    _artistLabel.text = data.artist;
    _composerLabel.text = data.composer;
    _lrcFirstLineLabel.text = data.lrcFirstLine;
}



@end

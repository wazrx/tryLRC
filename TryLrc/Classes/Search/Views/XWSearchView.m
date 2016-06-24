//
//  XWSearchView.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchView.h"
#import "XWCatergory.h"
#import <Masonry.h>

@implementation XWSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _xw_initailizeUI];
    }
    return self;
}

#pragma mark - initialize methods

- (void)_xw_initailizeUI{
    UIView *container = [UIView new];
    container.backgroundColor = XWhiteC;
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self).offset(widthRatio(-50));
    }];
    UILabel *titlLabel = [UILabel new];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"歌词搜索" attributes:@{NSFontAttributeName : XFont(40)}];
    [title appendAttributedString:[[NSAttributedString alloc] initWithString:@" for Uta-Net" attributes:@{NSFontAttributeName : XFont(15)}]];
    titlLabel.attributedText = title;
    titlLabel.textColor = XSkyBlueC;
    [container addSubview:titlLabel];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(container);
    }];
    UITextField *searchField = [UITextField new];
    _searchField = searchField;
    searchField.leftInsert = widthRatio(10);
    searchField.placeholder = @"请输入内容";
    searchField.text = @"dear";
    searchField.layer.borderColor = XSkyBlueC.CGColor;
    searchField.layer.borderWidth = widthRatio(1.5);
    searchField.layer.cornerRadius = widthRatio(8);
    [container addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlLabel.mas_bottom).offset(widthRatio(30));
        make.centerX.equalTo(container);
        make.width.mas_equalTo(widthRatio(300));
        make.height.mas_equalTo(widthRatio(50));
    }];
    NSArray *type = @[@"按曲名", @"按歌手", @"按作曲者"];
    UIView *typeButtonContainer = [UIView new];
    _typeButtonContainer = typeButtonContainer;
    typeButtonContainer.backgroundColor = XWhiteC;
    [container addSubview:typeButtonContainer];
    [typeButtonContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchField.mas_bottom).offset(widthRatio(6));
        make.centerX.equalTo(searchField);
        make.height.mas_equalTo(widthRatio(30));
    }];
    __block UIView *lastView = nil;
    [type enumerateObjectsUsingBlock:^(NSString *typeName, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeButton setTitle:typeName forState:UIControlStateNormal];
        [typeButton setTitleColor:XSkyBlueC forState:UIControlStateSelected];
        [typeButton setTitleColor:XGrayC forState:UIControlStateNormal];
        typeButton.titleLabel.font = XFont(16);
        [typeButtonContainer addSubview:typeButton];
        [typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastView) {
                make.left.equalTo(typeButtonContainer);
            }else{
                make.left.equalTo(lastView.mas_right).offset(widthRatio(15));
            }
            make.top.bottom.equalTo(typeButtonContainer);
        }];
        if (!idx) {
            typeButton.selected = YES;
        }
        lastView = typeButton;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(typeButtonContainer);
    }];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton = searchButton;
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitle:@"正在搜索..." forState:UIControlStateDisabled];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.layer.cornerRadius = widthRatio(10);
    searchButton.titleLabel.font = XFont(20);
    searchButton.backgroundColor = XSkyBlueC;
    [container addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(container);
        make.top.equalTo(typeButtonContainer.mas_bottom).offset(widthRatio(10));
        make.size.mas_equalTo(CGSizeMake(widthRatio(300), widthRatio(40)));
        make.bottom.equalTo(container);
    }];
}

- (void)xw_addTypeButtonTarget:(id)target selector:(SEL)selector {
	[_typeButtonContainer.subviews enumerateObjectsUsingBlock:^(UIButton *typeButton, NSUInteger idx, BOOL * _Nonnull stop) {
        [typeButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }];
}

@end

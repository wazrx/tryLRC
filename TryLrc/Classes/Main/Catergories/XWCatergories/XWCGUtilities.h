//
//  XWCGUtilities.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/16.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

CGFloat XWScreenScale();

CGFloat XWScreenWidthRatio();

CGFloat XWScreenHeightRatio();

CGSize XWScreenSize();

CGRect XWScreenBounds();



static inline CGFloat widthRatio(CGFloat number){
    return number * XWScreenWidthRatio();
}

static inline CGFloat heightRatio(CGFloat number){
    return number * XWScreenHeightRatio();
}

static inline CGFloat DegreesToRadians(CGFloat degrees){
    return degrees * M_PI / 180;
}

static inline CGFloat RadiansToDegrees(CGFloat radians){
    return radians * 180 / M_PI;
}


// main screen's scale
#ifndef kScreenScale
#define kScreenScale XWScreenScale()
#endif

// main screen's bounds
#ifndef kScreenBounds
#define kScreenBounds XWScreenBounds()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize XWScreenSize()
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth XWScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight XWScreenSize().height
#endif

// main screen's height (portrait)
#ifndef kWidthRatio
#define kWidthRatio XWScreenWidthRatio()
#endif

// main screen's height (portrait)
#ifndef kHeightRatio
#define kHeightRatio XWScreenHeightRatio()
#endif

NS_ASSUME_NONNULL_END
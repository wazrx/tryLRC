//
//  CALayer+XWAdd.h
//  XWCurrencyExchange
//
//  Created by YouLoft_MacMini on 16/1/28.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (XWAdd)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - snapShot(截图相关)

- (UIImage *)xw_snapshotImage;

- (NSData *)xw_snapshotPDF;

#pragma mark- shadow(阴影相关)

- (void)xw_shadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

#pragma mark - animation(动画相关)

- (void)xw_shakeInXWithDistace:(CGFloat)distance repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration;

- (void)xw_shakeInYWithDistace:(CGFloat)distance repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration;

- (void)xw_rotationInZWithAngle:(CGFloat)angle repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration;

#pragma mark - anchorPoint(锚点相关)

- (void)xw_anchorPointChangedToPoint:(CGPoint)point;

- (void)xw_anchorPointChangedTotopLeft;
- (void)xw_anchorPointChangedTotopCenter;
- (void)xw_anchorPointChangedToTopRight;
- (void)xw_anchorPointChangedToMidLeft;
- (void)xw_anchorPointChangedToMidCenter;
- (void)xw_anchorPointChangedToMidRight;
- (void)xw_anchorPointChangedToBottomLeft;
- (void)xw_anchorPointChangedToBottomCenter;
- (void)xw_anchorPointChangedToBottomRight;

#pragma mark - ohter

- (void)xw_removeAllSublayers;

#pragma mark -  fast property

@property (nonatomic) CGFloat x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint center;      ///< Shortcut for center.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size; ///< Shortcut for frame.size.


@property (nonatomic) CGFloat transformRotation;     ///< key path "tranform.rotation"
@property (nonatomic) CGFloat transformRotationX;    ///< key path "tranform.rotation.x"
@property (nonatomic) CGFloat transformRotationY;    ///< key path "tranform.rotation.y"
@property (nonatomic) CGFloat transformRotationZ;    ///< key path "tranform.rotation.z"
@property (nonatomic) CGFloat transformScale;        ///< key path "tranform.scale"
@property (nonatomic) CGFloat transformScaleX;       ///< key path "tranform.scale.x"
@property (nonatomic) CGFloat transformScaleY;       ///< key path "tranform.scale.y"
@property (nonatomic) CGFloat transformScaleZ;       ///< key path "tranform.scale.z"
@property (nonatomic) CGFloat transformTranslationX; ///< key path "tranform.translation.x"
@property (nonatomic) CGFloat transformTranslationY; ///< key path "tranform.translation.y"
@property (nonatomic) CGFloat transformTranslationZ; ///< key path "tranform.translation.z"
@property (nonatomic) CGFloat m34; //, -1/1000 is a good value.It should be set before other transform shortcut."


@end

NS_ASSUME_NONNULL_END

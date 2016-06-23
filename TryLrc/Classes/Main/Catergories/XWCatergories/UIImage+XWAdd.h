//
//  UIImage+XWAdd.h
//  WxSelected
//
//  Created by YouLoft_MacMini on 15/12/29.
//  Copyright © 2015年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XWAdd)

@property (nonatomic, readonly) BOOL hasAlphaChannel;

#pragma mark - image initailize (图片初始化相关)

+ (UIImage *)xwAdd_imageWithPDF:(id)dataOrPath;

+ (UIImage *)xwAdd_imageWithPDF:(id)dataOrPath size:(CGSize)size;

+ (UIImage *)xwAdd_imageWithEmoji:(NSString *)emoji size:(CGFloat)size;

/**尺寸默认1*1*/
+ (UIImage *)xwAdd_imageWithColor:(UIColor *)color;

+ (UIImage *)xwAdd_imageWithColor:(UIColor *)color size:(CGSize)size;

/**通过绘制block，绘制一张图片*/
+ (UIImage *)xwAdd_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

#pragma mark - modify image (图片修改相关, 裁剪，缩放，旋转)

- (nullable UIImage *)xwAdd_imageByResizeToSize:(CGSize)size;

- (nullable UIImage *)xwAdd_imageByCropToRect:(CGRect)rect;

- (nullable UIImage *)xwAdd_imageByInsetEdge:(UIEdgeInsets)insets withColor:(nullable UIColor *)color;

- (nullable UIImage *)xwAdd_imageByRoundCornerRadius:(CGFloat)radius;

- (nullable UIImage *)xwAdd_imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor;

- (nullable UIImage *)xwAdd_imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;

- (nullable UIImage *)xwAdd_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

- (nullable UIImage *)xwAdd_imageByRotateLeft90;

- (nullable UIImage *)xwAdd_imageByRotateRight90;

- (nullable UIImage *)xwAdd_imageByRotate180;

- (nullable UIImage *)xwAdd_imageByFlipVertical;

- (nullable UIImage *)xwAdd_imageByFlipHorizontal;

#pragma mark - effect image(给图片添加效果相关，如颜色、模糊等)

- (nullable UIImage *)xwAdd_imageByTintColor:(UIColor *)color;

- (nullable UIImage *)xwAdd_imageByGrayscale;

- (nullable UIImage *)xwAdd_imageByBlurSoft;

- (nullable UIImage *)xwAdd_imageByBlurLight;

- (nullable UIImage *)xwAdd_imageByBlurExtraLight;

- (nullable UIImage *)xwAdd_imageByBlurDark;

- (nullable UIImage *)xwAdd_imageByBlurWithTint:(UIColor *)tintColor;

- (nullable UIImage *)xwAdd_imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;
@end

NS_ASSUME_NONNULL_END
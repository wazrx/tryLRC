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

+ (UIImage *)xw_imageWithPDF:(id)dataOrPath;

+ (UIImage *)xw_imageWithPDF:(id)dataOrPath size:(CGSize)size;

+ (UIImage *)xw_imageWithEmoji:(NSString *)emoji size:(CGFloat)size;

/**尺寸默认1*1*/
+ (UIImage *)xw_imageWithColor:(UIColor *)color;

+ (UIImage *)xw_imageWithColor:(UIColor *)color size:(CGSize)size;

/**通过绘制block，绘制一张图片*/
+ (UIImage *)xw_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

#pragma mark - modify image (图片修改相关, 裁剪，缩放，旋转)

- (nullable UIImage *)xw_imageByResizeToSize:(CGSize)size;

- (nullable UIImage *)xw_imageByCropToRect:(CGRect)rect;

- (nullable UIImage *)xw_imageByInsetEdge:(UIEdgeInsets)insets withColor:(nullable UIColor *)color;

- (nullable UIImage *)xw_imageByRoundCornerRadius:(CGFloat)radius;

- (nullable UIImage *)xw_imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor;

- (nullable UIImage *)xw_imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;

- (nullable UIImage *)xw_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

- (nullable UIImage *)xw_imageByRotateLeft90;

- (nullable UIImage *)xw_imageByRotateRight90;

- (nullable UIImage *)xw_imageByRotate180;

- (nullable UIImage *)xw_imageByFlipVertical;

- (nullable UIImage *)xw_imageByFlipHorizontal;

#pragma mark - effect image(给图片添加效果相关，如颜色、模糊等)

- (nullable UIImage *)xw_imageByTintColor:(UIColor *)color;

- (nullable UIImage *)xw_imageByGrayscale;

- (nullable UIImage *)xw_imageByBlurSoft;

- (nullable UIImage *)xw_imageByBlurLight;

- (nullable UIImage *)xw_imageByBlurExtraLight;

- (nullable UIImage *)xw_imageByBlurDark;

- (nullable UIImage *)xw_imageByBlurWithTint:(UIColor *)tintColor;

- (nullable UIImage *)xw_imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;
@end

NS_ASSUME_NONNULL_END
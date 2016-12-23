//
//  ZITOLoadingView.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/10/27.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZITOLoadingView : UIView
/**
 *  show circle LoadingView
 *
 *  @param view showed
 */
+ (void)showCircleView:(UIView *)view;
/**
 *  show dot LoadingView
 *
 *  @param view showed
 */

+ (void)showDotView:(UIView *)view;

/**
 *  show line LoadingView
 *
 *  @param view showed
 */
+ (void)showLineView:(UIView *)view;

/**
 *  show CircleJoin LoadingView
 *
 *  @param view showed
 */
+ (void)showCircleJoinView:(UIView *)view;

/**
 *  hide loadingView
 */
+ (void)hide;
@end

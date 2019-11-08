//
//  SoundWaveView.h
//  Example
//
//  Created by 刘鹏i on 2019/11/7.
//  Copyright © 2019 Liupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface SoundWaveView : UIView
@property (nonatomic, assign) IBInspectable CGFloat minScale; ///< 初始比例大小（0~1）
@property (nonatomic, assign) IBInspectable NSInteger cycle;  ///< 周期（最多展示圆圈个数）
@property (nonatomic, assign) IBInspectable CGFloat speed;    ///< 速度（1秒内移动占本体的百分比）

@property (nonatomic, strong) IBInspectable UIColor *lineColor;///< 线的颜色
@property (nonatomic, assign) IBInspectable CGFloat minAlpha; ///< 最小透明度

/// 开始、继续
- (void)startAnimation;

/// 暂停
- (void)pauseAnimation;

@end

NS_ASSUME_NONNULL_END

//
//  SoundWaveView.m
//  Example
//
//  Created by 刘鹏i on 2019/11/7.
//  Copyright © 2019 Liupeng. All rights reserved.
//

#import "SoundWaveView.h"

@interface SoundWaveView ()
@property (nonatomic, assign) CGFloat offset;   ///< 偏移量（百分比）
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;///< 计时器
@end

@implementation SoundWaveView
#pragma mark - Life Circle
+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)dealloc {
    [_waveDisplaylink invalidate];
    [_waveDisplaylink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _waveDisplaylink = nil;
}

#pragma mark - Public
/// 开始、继续
- (void)startAnimation {
    if (_waveDisplaylink) {
        if (_waveDisplaylink.paused == YES) {
            [_waveDisplaylink setPaused:NO];
        }
    } else {
        _offset = _minScale;
        
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWave)];
        _waveDisplaylink.preferredFramesPerSecond = 40;// 帧数
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

/// 暂停
- (void)pauseAnimation {
    [_waveDisplaylink setPaused:YES];
}

#pragma mark - Private
/// 绘制波浪
- (void)drawWave
{
    [self.layer setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (_cycle <= 0) {
        return;
    }
        
    double width = self.bounds.size.width - 5;     // 整体宽
    double height = self.bounds.size.height - 5;   // 整体高
    
    // 计算偏移 (除以帧数)
    _offset += _speed / 40.0;
    
    // 取小数部分
    double decimal = _offset - floor(_offset);
    
    // 需要展示的不同比例的波纹
    NSMutableArray *arrScale = [[NSMutableArray alloc] init];
    // 逐渐缩小，算需要显示的圈
    double toSmall = decimal;
    while (toSmall >= _minScale) {
        [arrScale addObject:[NSNumber numberWithDouble:toSmall]];
        toSmall -= 1.0 / _cycle;
    }
    // 逐渐放大，算需要显示的圈
    if (_offset >= 1) {
        double toBig = decimal;
        while (toBig <= 1) {
            if (toBig != decimal) {
                [arrScale addObject:[NSNumber numberWithDouble:toBig]];
            }
            toBig += 1.0 / _cycle;
        }
    }

    // 画圈
    for (NSNumber *num in arrScale) {
        double scale = [num doubleValue];
        CGRect frame = CGRectMake((1 - scale) / 2.0 * width, 2, scale * width, scale * height);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
        path.lineWidth = 2.0;
        CGFloat alpha = 1 - (scale - _minScale) / (1 - _minScale) * (1 - _minAlpha);
        [[_lineColor colorWithAlphaComponent:alpha] set];
        [path stroke];
    }
}

/// 预览时调用，程序实际运行时不调用
- (void)prepareForInterfaceBuilder
{
    _offset = 1.1;
    [self drawWave];
}

@end

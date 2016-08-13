//
//  RefreshHeaderView.m
//  MoYu
//
//  Created by Chris on 16/8/13.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "RefreshHeaderView.h"
#import "ActivityIndicatorView.h"


@interface RefreshHeaderView ()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;

@property(nonatomic,strong) ActivityIndicatorView *indicatorView;
@end

@implementation RefreshHeaderView

-(void)prepare
{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    if (!self.indicatorView) {
        self.indicatorView = [[ActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:self.indicatorView];
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.indicatorView.center = CGPointMake(size.width/2, self.frame.size.height/2);
    [self.indicatorView startAnimation];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        [self.indicatorView startAnimation];
    }
    
    if (state == MJRefreshStateIdle) {
        [self.indicatorView stopAnimation];
    }
}
@end

//
//  ActivityIndicatorView.m
//  MoYu
//
//  Created by Chris on 16/8/13.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "ActivityIndicatorView.h"
#import "ActivityIndicatorAnimation.h"

@interface ActivityIndicatorView ()

@property(nonatomic,strong) UIColor *color;

@property(nonatomic,strong) NSArray *colors;

@property(nonatomic,assign) BOOL hidesWhenStopped;

@property(nonatomic,assign) BOOL animating;

@property(nonatomic,assign) CGSize size;

@end

@implementation ActivityIndicatorView

-(instancetype) initWithCoder:(nonnull NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.color = [UIColor whiteColor];
        self.size = CGSizeMake(30, 30);
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.color = [UIColor whiteColor];
        self.size = CGSizeMake(30,30);
    }
    return self;
}

-(void) startAnimation{
    if (self.hidesWhenStopped && self.hidden) {
        self.hidden = NO;
    }
    if (self.layer.sublayers == nil) {
        [self setUpAnimation];
    }
    self.layer.speed = 1;
    self.animating = YES;
}

-(void) stopAnimation{
    self.layer.speed = 0;
    self.animating = NO;
    if (self.hidesWhenStopped && !self.hidden) {
        self.hidden = YES;
    }
}

-(void) setUpAnimation{
    
    NSArray *colors = @[[UIColor colorWithRed:1.0 green:0.4 blue:0.4 alpha:1.0],
                        [UIColor colorWithRed:1.0 green:0.8 blue:0.4 alpha:1.0],
                        [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    
    ActivityIndicatorAnimation *animation = [[ActivityIndicatorAnimation alloc] initWithColors:colors];
    
    [animation setUpAnimationInLayer:self.layer size:self.size color:self.color];
}

@end

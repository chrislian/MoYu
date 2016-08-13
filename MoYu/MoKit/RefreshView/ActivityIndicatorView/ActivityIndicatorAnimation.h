//
//  ActivityIndicatorAnimation.h
//  MoYu
//
//  Created by Chris on 16/8/13.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicatorAnimation: NSObject

- (instancetype) initWithColors:(NSArray *) colors;

- (void) setUpAnimationInLayer:(CALayer *)layer size:(CGSize)size color:(UIColor *)color;

@end

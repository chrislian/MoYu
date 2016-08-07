//
//  OLGhostAlertView.m
//
//  Originally created by Radu Dutzan.
//  (c) 2012-2013 Onda.
//

#import <QuartzCore/QuartzCore.h>
#import "OLGhostAlertView.h"
#define HORIZONTAL_PADDING 18.0
#define VERTICAL_PADDING 10.0
#define TITLE_FONT_SIZE 17
#define MESSAGE_FONT_SIZE 14
#define MQ_DEFAULT_DISMISS_TIME 1
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
#define NSTextAlignmentCenter UITextAlignmentCenter
#define NSLineBreakByWordWrapping UILineBreakModeWordWrap
#endif

@interface OLGhostAlertView ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UITapGestureRecognizer *dismissTap;
@property UIInterfaceOrientation interfaceOrientation;
@property BOOL keyboardIsVisible;
@property CGFloat keyboardHeight;
@property (nonatomic, readwrite) BOOL visible;
@property (nonatomic,strong) NSTimer *mqTimer;
@property (nonatomic,strong) UIView *mqMaskView;
@end

@implementation OLGhostAlertView

#pragma mark - Initialization

+ (instancetype)shareInstance
{
    static OLGhostAlertView *shareInstance = nil;
    //代码执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class]alloc]init];
    });
    return shareInstance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        self.backgroundColor = [UIColor colorWithRed:0.9882 green:0.7569 blue:0.051 alpha:0.8];
        self.alpha = 0;
        self.isNeedPadding = YES;
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            self.layer.shadowColor = [UIColor blackColor].CGColor;
            self.layer.shadowOpacity = 0.7f;
            self.layer.shadowRadius = 5.0f;
            self.layer.shadowOffset = CGSizeMake(0, 2);
        } else {
            self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
            self.layer.shadowOffset = CGSizeMake(0, 0);
            self.layer.shadowOpacity = 1.0;
            self.layer.shadowRadius = 30.0;
            
            UIMotionEffectGroup *motionEffects = [UIMotionEffectGroup new];
            
            UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
            horizontalMotionEffect.minimumRelativeValue = @-21;
            horizontalMotionEffect.maximumRelativeValue = @21;
            
            UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            verticalMotionEffect.minimumRelativeValue = @-25;
            verticalMotionEffect.maximumRelativeValue = @25;
            
            motionEffects.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
            
            [self addMotionEffect:motionEffects];
        }
        
        _titleLabel                  = [[UILabel alloc] initWithFrame:CGRectMake(HORIZONTAL_PADDING, VERTICAL_PADDING, 200, 200)];
        _titleLabel.backgroundColor  = [UIColor clearColor];
        _titleLabel.textColor        = [UIColor whiteColor];
        _titleLabel.textAlignment    = NSTextAlignmentCenter;
        _titleLabel.font             = [UIFont boldSystemFontOfSize:TITLE_FONT_SIZE];
        _titleLabel.numberOfLines    = 0;
//        _titleLabel.lineBreakMode    = NSLineBreakByWordWrapping;
        _titleLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        
        [self addSubview:_titleLabel];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(HORIZONTAL_PADDING, 0, 0, 0)];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        
        [self addSubview:_messageLabel];
        
        self.style = OLGhostAlertViewStyleDefault;
        _position = OLGhostAlertViewPositionBottom;
        
        _interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _bottomMargin = 25;
        else
            _bottomMargin = 50;
        
        _dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeOrientation:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        _timeout =  MQ_DEFAULT_DISMISS_TIME;
        _dismissible = YES;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message timeout:(NSTimeInterval)timeout dismissible:(BOOL)dismissible
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.title       = title;
        self.message     = message;
        self.timeout     = timeout;
        self.dismissible = dismissible;
        self.timeout     = MQ_DEFAULT_DISMISS_TIME;
        [self setDismissible:YES];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [self initWithTitle:title message:message timeout:_timeout dismissible:YES];
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    self = [self initWithTitle:title message:nil timeout:_timeout dismissible:YES];
    return self;
}

- (id)initWithTitle:(NSString *)title timeout:(NSTimeInterval)timeout
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.title       = title;
        self.message     = nil;
        self.timeout     = timeout;
    }
    return self;
}

- (id)initWithCustomView:(UIView *)customView timeout:(NSTimeInterval)timeout
{
    self = [self initWithFrame:customView.frame];
    if (self) {
        self.title = nil;
        self.message = nil;
        self.customView  = customView;
        self.timeout     = timeout;
    }
    return self;
}

#pragma mark - Show and hide

- (void)show
{
    //if (!self.title && !self.message)
        //NSLog(@"OLGhostAlertView: Your alert doesn't have any content.");
    
    if (self.isVisible || [self superview]) return;
    
    UIViewController *parentController = [[[UIApplication sharedApplication] delegate] window].rootViewController;

    while (parentController.presentedViewController)
        parentController = parentController.presentedViewController;
    
    UIView *parentView = parentController.view;   
//    CGRect frame = parentView.bounds;
//    self.frame = CGRectMake((parentView.frame.size.height-frame.size.height)/2, (parentView.frame.size.width - frame.size.width)/2, frame.size.width, frame.size.height);
    
    [self showInView:parentView];
}

- (void)showInWindow
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (!self.isNeedPadding) {
        self.mqMaskView = [[UIView alloc] initWithFrame:window.bounds];
        self.mqMaskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [self.mqMaskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapMaskView:)]];
        [window addSubview:self.mqMaskView];
    }
    [self showInView:window];
}

-(void)onTapMaskView:(id)sender{
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf hide:NO];
        weakSelf.mqMaskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [weakSelf.mqMaskView removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view
{
    if([self superview])
    {
        return;
    }
    @try {
        for (UIView *subview in [view subviews]) {
            if ([subview isKindOfClass:[OLGhostAlertView class]]) {
                OLGhostAlertView *otherOLGAV = (OLGhostAlertView *)subview;
                [otherOLGAV hide:FALSE];
            }
        }
        [view addSubview:self];
        
        self.visible = YES;
        if(self.mqTimer)
        {
            if([self.mqTimer isValid])
            {
                [self.mqTimer invalidate];
            }
            self.mqTimer = nil;
        }        
        if(self.timeout > 0)
        {
            self.mqTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeout target:self selector:@selector(hide) userInfo:nil repeats:NO];
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
//            if (self.timeout >= 0)
//            {
//                [self performSelector:@selector(hide) withObject:nil afterDelay:self.timeout];
//            }        
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
}

-(void)hide:(BOOL)animate
{    
    if(![self superview])
    {
        return ;
    }
    __weak __typeof(self) weakSelf = self;
        
    [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf];
    if(animate)
    {
        [UIView animateWithDuration:1 animations:^{
            weakSelf.alpha = 0;
        } completion:^(BOOL finished){
            weakSelf.visible = NO;
            [weakSelf.mqMaskView removeFromSuperview];
            [weakSelf removeFromSuperview];
            if (weakSelf.completionBlock)
            {
                weakSelf.completionBlock();
            }
        }];
        
    }
    else
    {
        [weakSelf.mqMaskView removeFromSuperview];
        [weakSelf removeFromSuperview];
        weakSelf.visible = NO;
        if (weakSelf.completionBlock)
        {
            weakSelf.completionBlock();
        }
    }
    
}
- (void)hide
{
    [self hide:TRUE];
}

#pragma mark - View layout

- (void)layoutSubviews
{
    CGFloat maxWidth = 0;
    CGFloat totalLabelWidth = 0;
    CGFloat totalHeight = 0;
    
    CGRect screenRect = self.superview.bounds;
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        if (UIDeviceOrientationIsPortrait((UIDeviceOrientation)self.interfaceOrientation))
//            maxWidth = 280 - (HORIZONTAL_PADDING * 2);
//        else
//            maxWidth = 420 - (HORIZONTAL_PADDING * 2);
//    } else {
//        maxWidth = 520 - (HORIZONTAL_PADDING * 2);
//    }
    
    maxWidth = [[UIScreen mainScreen] bounds].size.width-50;
    
    CGSize constrainedSize = CGSizeZero;
    constrainedSize.width = maxWidth;
    constrainedSize.height = MAXFLOAT;
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize titleSize = [self.title sizeWithFont:[UIFont boldSystemFontOfSize:TITLE_FONT_SIZE] constrainedToSize:constrainedSize];
   
    CGSize messageSize = CGSizeZero;
    
    if (self.message) {
        messageSize = [self.message sizeWithFont:[UIFont systemFontOfSize:MESSAGE_FONT_SIZE] constrainedToSize:constrainedSize];
        
        totalHeight = titleSize.height + messageSize.height + floorf(VERTICAL_PADDING * 2.5);
        
    } else {
        totalHeight = titleSize.height + floorf(VERTICAL_PADDING * 2);
    }
    
    if (self.customView)
    {
        totalHeight = self.customView.frame.size.height;
    }
    
    #pragma clang diagnostic pop
    if (titleSize.width == maxWidth || messageSize.width == maxWidth)
        totalLabelWidth = maxWidth;
    
    else if (messageSize.width > titleSize.width)
        totalLabelWidth = messageSize.width;
    
    else
        totalLabelWidth = titleSize.width;

    if (self.customView)
    {
        totalLabelWidth = self.customView.frame.size.width;
    }
    
    CGFloat totalWidth = totalLabelWidth;
    if (self.isNeedPadding) {
        totalWidth = totalLabelWidth + (HORIZONTAL_PADDING * 2);
    }
    
    CGFloat xPosition = floorf((screenRect.size.width / 2) - (totalWidth / 2));
    
    CGFloat yPosition = 0;
    
    switch (self.position) {
        case OLGhostAlertViewPositionBottom:
        default:
            yPosition = screenRect.size.height - ceilf(totalHeight) - self.bottomMargin;
            break;
            
        case OLGhostAlertViewPositionCenter:
            yPosition = ceilf((screenRect.size.height / 2) - (totalHeight / 2));
            break;
            
        case OLGhostAlertViewPositionTop:
            yPosition = self.bottomMargin;
            break;
    }
   
    self.frame = CGRectMake(xPosition, yPosition, ceilf(totalWidth), ceilf(totalHeight));
    
//    if (self.keyboardIsVisible && self.position == OLGhostAlertViewPositionBottom)
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - self.keyboardHeight, self.frame.size.width, self.frame.size.height);
//    
//    if (self.keyboardIsVisible && self.position == OLGhostAlertViewPositionCenter)
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y*2 - self.keyboardHeight, self.frame.size.width, self.frame.size.height);

    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, ceilf(self.titleLabel.frame.origin.y), ceilf(totalLabelWidth), ceilf(titleSize.height));
    
    if (self.messageLabel) 
        self.messageLabel.frame = CGRectMake(self.messageLabel.frame.origin.x, ceilf(titleSize.height) + floorf(VERTICAL_PADDING * 1.5), ceilf(totalLabelWidth), ceilf(messageSize.height));
    
    if (self.customView && self.isNeedPadding)
    {
        CGRect frame = self.customView.frame;
        [_customView setFrame:CGRectMake(HORIZONTAL_PADDING, frame.origin.y, frame.size.width - 2*HORIZONTAL_PADDING, frame.size.height)];
    }
}
#pragma mark - 键盘弹出时的事件
- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    CGSize keyboardSize = [[keyboardInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardIsVisible = YES;
    self.keyboardHeight = keyboardSize.height;
    
    [self setNeedsLayout];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    self.keyboardIsVisible = NO;
    
    [self setNeedsLayout];
}

#pragma mark - Orientation handling
- (void)didChangeOrientation:(NSNotification *)notification
{
    self.interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    [self setNeedsLayout];
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setDismissible:YES];
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
}

- (void)setMessage:(NSString *)message
{
    if(message != NULL)
    {
        _message = message;
        
        self.messageLabel.text = message;
        
        [self setNeedsLayout];
    }
    else
    {
        message = nil;
        self.messageLabel.text = nil;
    }
    
}

- (void)setCustomView:(UIView *)customView
{
    if(_customView)
    {
        if([_customView superview])
        {
            [_customView removeFromSuperview];
 
        }
        _customView = nil;
    }
    
    if (customView)
    {
        _customView = customView;
        [self addSubview:_customView];
    }
   
    [self setNeedsLayout];
}

- (void)setDismissible:(BOOL)dismissible
{
    _dismissible = dismissible;
    
    if (dismissible)
        [self addGestureRecognizer:self.dismissTap];
    else
        if (self.gestureRecognizers) [self removeGestureRecognizer:self.dismissTap];
}

- (void)setStyle:(OLGhostAlertViewStyle)style
{
    OLGhostAlertViewStyle defaultStyle = OLGhostAlertViewStyleDark;
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        defaultStyle = OLGhostAlertViewStyleLight;
    
    if (style == OLGhostAlertViewStyleDefault) style = defaultStyle;
    
    _style = style;
}

#pragma mark - Cleanup

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
    [self removeGestureRecognizer:self.dismissTap];
}

@end

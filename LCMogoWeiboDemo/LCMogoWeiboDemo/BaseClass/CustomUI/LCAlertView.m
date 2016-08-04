//
//  LCAlertVIew.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/10.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCAlertVIew.h"
#define kTitleFont [UIFont systemFontOfSize:18]
#define kMessageFont [UIFont systemFontOfSize:16]
#define kBtnFont [UIFont systemFontOfSize:18]

#define kTitleTextColor [UIColor colorWithHexString:@"#303030" alpha:1]
//#define kBtnTextColor [UIColor colorWithHexString:@"#ffa800" alpha:1]
#define kBtnTextColor kYGTBaseColor


#define MARGIN_TOP 15//alertV的高度
#define MARGIN_LEFT_LARGE 30
#define MARGIN_LEFT_SMALL 15
#define MARGIN_RIGHT_LARGE 30
#define MARGIN_RIGHT_SMALL 15
#define SPACE_LARGE 10
#define SPACE_SMALL 5
#define MESSAGE_LINE_SPACE 5


NSString *const kNotificationAlertViewClick = @"notificationAlertViewClick";
//按钮index 键
NSString *const kIndex = @"index";

@interface LCAlertView ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *buttonTitleArray;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;
@implementation LCAlertView
- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = kTitleTextColor;
        [self addSubview:_backgroundView];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)iconImage message:(NSString *)message delegate:(id<LCAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ...
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _iconImage = iconImage;
        _title = title;
        _message = message;
        _delegate = delegate;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];
        
        va_list args;
        va_start(args, buttonTitles);
        if (buttonTitles)
        {
            [_buttonTitleArray addObject:buttonTitles];
            while (1)
            {
                NSString *  otherButtonTitle = va_arg(args, NSString *);
                if(otherButtonTitle == nil) {
                    break;
                } else {
                    [_buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = kTitleTextColor;
        [self addSubview:_backgroundView];
        [self initContentView];
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    _contentView.center = self.center;
    [self addSubview:_contentView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self initContentView];
}
- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    [self initContentView];
}


- (void)setMessage:(NSString *)message {
    _message = message;
    [self initContentView];
}

// Init the content of content view
- (void)initContentView {
    contentViewWidth = 250 * self.frame.size.width / 320;
    contentViewHeight = MARGIN_TOP;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 5.0;
    _contentView.layer.masksToBounds = YES;
    
    [self initTitleAndIcon];
    [self initMessage];
    [self initAllButtons];
    
    _contentView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
    _contentView.center = self.center;
    [self addSubview:_contentView];
}

// Init the title and icon
- (void)initTitleAndIcon {
    
    if (_title == nil && _iconImage == nil) {
        return;
    }
    _titleView = [[UIView alloc] init];
    if (_iconImage != nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = _iconImage;
        _iconImageView.frame = CGRectMake(0, 0, 20, 20);
        [_titleView addSubview:_iconImageView];
    }
    
    CGSize titleSize = [self getTitleSize];
    if (_title != nil && ![_title isEqualToString:@""]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = _title;
        _titleLabel.textColor = kTitleTextColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = kTitleFont;
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.frame = CGRectMake(_iconImageView.frame.origin.x + _iconImageView.frame.size.width + SPACE_SMALL, 1, titleSize.width, titleSize.height);
        [_titleView addSubview:_titleLabel];
        
    }
    
    _titleView.frame = CGRectMake(0, MARGIN_TOP, _iconImageView.frame.size.width + SPACE_SMALL + titleSize.width, MAX(_iconImageView.frame.size.height, titleSize.height));
    _titleView.center = CGPointMake(contentViewWidth / 2, MARGIN_TOP + _titleView.frame.size.height / 2);
    [_contentView addSubview:_titleView];
    contentViewHeight += _titleView.frame.size.height + SPACE_LARGE;
    
    UIView *horizonSperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.frame.origin.y + _titleView.frame.size.height + SPACE_LARGE, contentViewWidth, 1)];
    horizonSperatorView.backgroundColor = kRGBACOLOR(218, 218, 222, 1.0);
    
    [_contentView addSubview:horizonSperatorView];

}


// Init the message
- (void)initMessage {
    if (_message != nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = _message;
        _messageLabel.textColor = kTitleTextColor;
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = kMessageFont;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = MESSAGE_LINE_SPACE;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
        _messageLabel.attributedText = [[NSAttributedString alloc]initWithString:_message attributes:attributes];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize messageSize = [self getMessageSize];
        _messageLabel.frame = CGRectMake(MARGIN_LEFT_LARGE,contentViewHeight  +SPACE_LARGE, MAX(contentViewWidth - MARGIN_LEFT_LARGE - MARGIN_RIGHT_LARGE, messageSize.width), messageSize.height);
        [_contentView addSubview:_messageLabel];
        contentViewHeight += SPACE_LARGE + _messageLabel.frame.size.height;
        }
}

// Init all the buttons according to button titles
- (void)initAllButtons {
    if (_buttonTitleArray.count > 0) {
        contentViewHeight += SPACE_LARGE + 45;
        UIView *horizonSperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, _messageLabel.frame.origin.y + _messageLabel.frame.size.height + SPACE_LARGE, contentViewWidth, 1)];
        horizonSperatorView.backgroundColor = kRGBACOLOR(218, 218, 222, 1.0);
        
        [_contentView addSubview:horizonSperatorView];
        
        CGFloat buttonWidth = contentViewWidth / _buttonTitleArray.count;
        for (NSString *buttonTitle in _buttonTitleArray) {
            NSInteger index = [_buttonTitleArray indexOfObject:buttonTitle];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(index * buttonWidth, horizonSperatorView.frame.origin.y + horizonSperatorView.frame.size.height, buttonWidth, 44)];
            button.titleLabel.font = kBtnFont;
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            [button setTitleColor:kBtnTextColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonWithPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_contentView addSubview:button];
            
            if (index < _buttonTitleArray.count - 1) {
                UIView *verticalSeperatorView = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y, 1, button.frame.size.height)];
                verticalSeperatorView.backgroundColor = kRGBACOLOR(218, 218, 222, 1.0);
                
                [_contentView addSubview:verticalSeperatorView];
            }
        }
    }
}

// Get the size fo title
- (CGSize)getTitleSize {
    UIFont *font = kTitleFont;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(contentViewWidth - (MARGIN_LEFT_SMALL + MARGIN_RIGHT_SMALL + _iconImageView.frame.size.width + SPACE_SMALL), 2000)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes context:nil].size;
    
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

// Get the size of message
- (CGSize)getMessageSize {
    UIFont *font = kMessageFont;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = MESSAGE_LINE_SPACE;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [_message boundingRectWithSize:CGSizeMake(contentViewWidth - (MARGIN_LEFT_LARGE + MARGIN_RIGHT_LARGE), 2000)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes context:nil].size;
    
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (void)buttonWithPressed:(UIButton *)button {
    
    NSInteger index = [_buttonTitleArray indexOfObject:button.titleLabel.text];
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_delegate alertView:self clickedButtonAtIndex:index];
    }
    //当被点击的时候发送通知
    NSNumber *indexNumber = [NSNumber numberWithInteger:index];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:indexNumber,kIndex ,nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAlertViewClick object:nil userInfo:dic];
    
    [self hide];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0){
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }
}

- (void)hide {
    
    
    [UIView animateWithDuration:0.25 animations:^{
        _contentView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        _contentView.hidden = YES;
        [self hideAlertAnimation];
        [self removeFromSuperview];
    }];
    
}

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    
    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _messageLabel.textColor = color;
    }
    
    if (size > 0) {
        _messageLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index {
    UIButton *button = _buttonArray[index];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (size > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)showBackground
{
    _backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.6;
    [UIView commitAnimations];
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
}

- (void)hideAlertAnimation {
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0;
    [UIView commitAnimations];
}


@end

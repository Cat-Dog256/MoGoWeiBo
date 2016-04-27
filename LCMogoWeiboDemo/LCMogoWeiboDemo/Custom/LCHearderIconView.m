//
//  LCHearderIconView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/25.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCHearderIconView.h"
#import "LCUserInfoModel.h"
#import "UIImageView+WebCache.h"
@interface LCHearderIconView ()
@property (nonatomic , weak) UIImageView *iconImageView;
@property (nonatomic , weak) UIImageView *typeImageView;
@end

@implementation LCHearderIconView
- (UIImageView *)typeImageView{
    if (_typeImageView == nil) {
        UIImageView *typeImageView = [[UIImageView alloc]init];
        typeImageView.layer.borderWidth = kBorderLineThickness;
        typeImageView.layer.borderColor = kBorderLineColor.CGColor;
        [self addSubview:typeImageView];
        
        self.typeImageView = typeImageView;
    }
    return _typeImageView;
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *iconImageView = [[UIImageView alloc]init];
        iconImageView.contentMode = UIViewContentModeRedraw;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.backgroundColor = [UIColor redColor];
        iconImageView.layer.borderWidth = kBorderLineThickness;
        iconImageView.layer.borderColor = kBorderLineColor.CGColor;
        self.iconImageView = iconImageView;

        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)setUserModel:(LCUserInfoModel *)userModel{
    _userModel = userModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (userModel.verified_type) {
        case UserVerifiedTypeNone:
            self.typeImageView.hidden = YES;
            
            //            self.typeImageView.image = nil;
            break;
        case UserVerifiedTypePersonal:
            self.typeImageView.hidden = NO;
            
            self.typeImageView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case UserVerifiedTypeDaren:
            self.typeImageView.hidden = NO;
            
            self.typeImageView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        case UserVerifiedTypeOrgEnterprice:
            self.typeImageView.hidden = NO;
            
            self.typeImageView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case UserVerifiedTypeOrgMedia:
            self.typeImageView.hidden = NO;
            self.typeImageView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case UserVerifiedTypeOrgWebsite:
            self.typeImageView.hidden = NO;
            self.typeImageView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        default:
            break;
    }
    [self.typeImageView sizeToFit];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconImageView.size = self.size;
    self.iconImageView.layer.cornerRadius = self.width/2;

    self.typeImageView.frame = CGRectMake(self.frame.size.width - self.typeImageView.width, self.frame.size.height - self.typeImageView.width, self.typeImageView.width, self.typeImageView.width);
    self.typeImageView.layer.cornerRadius = self.typeImageView.width/2;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

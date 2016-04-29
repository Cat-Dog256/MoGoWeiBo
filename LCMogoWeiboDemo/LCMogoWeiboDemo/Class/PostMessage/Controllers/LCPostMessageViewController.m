//
//  LCPostMessageViewController.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCPostMessageViewController.h"
#import "LCPlaceholderTextView.h"
#import "LCKeyboardToolBar.h"
#import "LCEmotionKeyboardView.h"
@interface LCPostMessageViewController ()<UITextViewDelegate , LCKeyboardToolBarDelegate>
@property (nonatomic, weak) LCPlaceholderTextView *messageTextView;
@property (nonatomic , strong) LCKeyboardToolBar *myKeyboardToolBar;
@property (nonatomic , strong) LCEmotionKeyboardView *emotionKeyboard;
/**
 *  切换键盘标记,工具条不动
 */
@property (nonatomic , assign) BOOL switchingKeybaord;
@end

@implementation LCPostMessageViewController
- (LCEmotionKeyboardView *)emotionKeyboard{
    if (!_emotionKeyboard) {
        _emotionKeyboard = [[LCEmotionKeyboardView alloc]init];
        _emotionKeyboard.width = SCREEN_WIDTH;
        _emotionKeyboard.height = 261;
    }
    return _emotionKeyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = kBgDarkColor;
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setNavigtionItem];

    [self setupTextView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//键盘高度发生变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)setupTextView{
    LCPlaceholderTextView *textView = [[LCPlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64)];
#pragma mark -- 注意 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [textView becomeFirstResponder];
    //    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction)];
    //    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    //    [self.view addGestureRecognizer:swipeDown];
    [self.view addSubview:textView];
    self.messageTextView = textView;
    
    
    self.myKeyboardToolBar = [[LCKeyboardToolBar alloc]initWithFrame_Y:CGRectGetMaxY(textView.frame)];
    self.myKeyboardToolBar.delegate = self;
    [self.view addSubview:self.myKeyboardToolBar];
}
#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{   LCLogInfo(@"");
    [self.view endEditing:YES];
}

- (void)swipeDownAction{
    [self.messageTextView resignFirstResponder];
}
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    
    // 键盘的frame
    CGFloat keyboardH = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self changeKeyboard_Y:(SCREEN_HEIGHT - keyboardH - self.myKeyboardToolBar.height - 100)];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    [self changeKeyboard_Y:(SCREEN_HEIGHT - self.myKeyboardToolBar.height)];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    /**
     *  {
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 667}, {375, 261}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 536.5},
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 261}},
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 406}, {375, 261}},
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 797.5},
     UIKeyboardAnimationCurveUserInfoKey = 7,
     UIKeyboardIsLocalUserInfoKey = 1
     }
     */
    
    if (self.switchingKeybaord) return;
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.myKeyboardToolBar.y = self.view.height - self.myKeyboardToolBar.height;
        } else {
            self.myKeyboardToolBar.y = keyboardF.origin.y - self.myKeyboardToolBar.height - 64;
        }
    }];

}
- (void)changeKeyboard_Y:(CGFloat)Y{
    // 执行动画
    [UIView animateWithDuration:0.25 animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
            self.myKeyboardToolBar.y = Y;
    }];

}
- (void)setNavigtionItem{
    self.navigationItem.title = @"沉淀繁华";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    
}
- (void)sendMessage{
    LCLogInfo();
}
- (void)pressLeftButtonAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)keyboardToolbar:(LCKeyboardToolBar *)toolbar didClickButton:(LCKeyboardToolbarButtonType)buttonType{
    if (buttonType == LCKeyboardToolbarButtonTypeEmotion) {
        /**
         *  切换按钮的图片
         */
        self.myKeyboardToolBar.showKeyboardButton = !self.myKeyboardToolBar.showKeyboardButton;
        
        self.switchingKeybaord = YES;
        if (self.messageTextView.inputView == nil) { // 切换为自定义的表情键盘
            self.messageTextView.inputView = self.emotionKeyboard;
        } else { // 切换为系统自带的键盘
            self.messageTextView.inputView = nil;
        }
        
        // 退出键盘
        [self.messageTextView endEditing:YES];
        //    [self.view endEditing:YES];
        //    [self.view.window endEditing:YES];
        //    [self.textView resignFirstResponder];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 弹出键盘
            [self.messageTextView becomeFirstResponder];
            
            // 结束切换键盘
            self.switchingKeybaord = NO;
        });

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  LCPostMessageViewController.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCPostMessageViewController.h"
#import "LCEmotionTextView.h"
#import "LCKeyboardToolBar.h"
#import "LCEmotionKeyboardView.h"
#import "LCEmotionModel.h"
#import "NSString+Emoji.h"

#import "LCPostMessageReformer.h"
#import "LCPostMessageHavePhotosReformer.h"
@interface LCPostMessageViewController ()<UITextViewDelegate , LCKeyboardToolBarDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate>
@property (nonatomic, weak) LCEmotionTextView *messageTextView;
@property (nonatomic , strong) LCKeyboardToolBar *myKeyboardToolBar;
@property (nonatomic , strong) LCEmotionKeyboardView *emotionKeyboard;

@property (nonatomic , strong) LCPostMessageReformer *postMessageReformer;
@property (nonatomic , strong) LCPostMessageHavePhotosReformer *photosReformer;



@property (nonatomic , strong) NSMutableArray *imageArray;
/**
 *  切换键盘标记,工具条不动
 */
@property (nonatomic , assign) BOOL switchingKeybaord;
@end

@implementation LCPostMessageViewController
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (LCPostMessageReformer *)postMessageReformer{
    if (!_postMessageReformer) {
        _postMessageReformer = [[LCPostMessageReformer alloc]init];
        _postMessageReformer.delegate = self;
        _postMessageReformer.access_token = @"2.00j15PRBdmFKEBc0e4acca150rXv9S";
    }
    return _postMessageReformer;
}
- (LCPostMessageHavePhotosReformer *)photosReformer{
    if (!_photosReformer) {
        _photosReformer = [[LCPostMessageHavePhotosReformer alloc]init];
        _photosReformer.delegate = self;
        _photosReformer.access_token = @"2.00j15PRBdmFKEBc0e4acca150rXv9S";
    }
    return _photosReformer;
}
- (LCEmotionKeyboardView *)emotionKeyboard{
    if (!_emotionKeyboard) {
        _emotionKeyboard = [[LCEmotionKeyboardView alloc]init];
        _emotionKeyboard.width = SCREEN_WIDTH;
    }
    return _emotionKeyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = kBgDarkColor;
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    //设置导航栏
    [self setNavigtionItem];
    //初始化输入框
    [self setupTextView];
    
    //键盘高度发生变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
   //选中表情的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pressEmotionsKeyboard:) name:kLCEmotionKeyboardDidSelectedEmotiomNotification object:nil];
    //表情键盘删除按钮的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressDeletedKeyboard:) name:kLCEmotionKeyboardDidSelectedDeletedNotification object:nil];;
    // Do any additional setup after loading the view from its nib.
}
#pragma  mark --设置导航栏
- (void)setNavigtionItem{
    self.navigationItem.title = @"沉淀繁华";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    
}

#pragma mark --发微博
- (void)sendMessage{
    self.postMessageReformer.status = self.messageTextView.fullText;
    self.postMessageReformer.imagesArray = self.imageArray;
    [self.postMessageReformer requestDataWithHUDView:self.view];
    LCLogInfo(@"%@",self.messageTextView.fullText);
}
- (void)reformerSuccessWith:(LCBaseReformer *)reformer object:(id)object{
    LCLogWarn(@"%@",object);
}
- (void)reformerFailureWith:(LCBaseReformer *)reformer{
    LCLogWarn(@"%@",reformer.response.error);
}
#pragma mark --返回
- (void)pressLeftButtonAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --初始化输入框
- (void)setupTextView{
    LCEmotionTextView *textView = [[LCEmotionTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64)];
#pragma mark -- 注意 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [textView becomeFirstResponder];
    
    [self.view addSubview:textView];
    self.messageTextView = textView;
    
    
    self.myKeyboardToolBar = [[LCKeyboardToolBar alloc]initWithFrame_Y:CGRectGetMaxY(textView.frame)];
    self.myKeyboardToolBar.delegate = self;
    [self.view addSubview:self.myKeyboardToolBar];
}

#pragma mark --表情键盘的删除按钮
- (void)pressDeletedKeyboard:(NSNotification *)noti{
    /**
     * 删除
     */
    [self.messageTextView deleteBackward];
}
#pragma mark --选中的表情
- (void)pressEmotionsKeyboard:(NSNotification *)noti{
    LCEmotionModel *model = noti.userInfo[kSelectedEmotionInfo];
    [self.messageTextView insertEmotion:model];
}

#pragma mark --键盘改变的通知
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
    self.emotionKeyboard.height = keyboardF.size.height;
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


#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark -- LCKeyboardToolBarDelegate
- (void)keyboardToolbar:(LCKeyboardToolBar *)toolbar didClickButton:(LCKeyboardToolbarButtonType)buttonType{
    
    switch (buttonType) {
        case LCKeyboardToolbarButtonTypeCamera:
            [self takePhoto];
            break;
        case LCKeyboardToolbarButtonTypePicture:
            [self localPhoto];
            break;
        case LCKeyboardToolbarButtonTypeMention:
        break;
        case LCKeyboardToolbarButtonTypeTrend:
        break;
        case LCKeyboardToolbarButtonTypeEmotion:{
            /**
             *  切换按钮的图片
             */
            self.myKeyboardToolBar.showKeyboardButton = !self.myKeyboardToolBar.showKeyboardButton;
            if (self.myKeyboardToolBar.y != SCREEN_HEIGHT - self.myKeyboardToolBar.height - 64) {
                self.switchingKeybaord = YES;

            }

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

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 弹出键盘
                [self.messageTextView becomeFirstResponder];
                
                // 结束切换键盘
                self.switchingKeybaord = NO;
            });
            
        }
        break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    /**
     *  删除通知
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLCEmotionKeyboardDidSelectedDeletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLCEmotionKeyboardDidSelectedEmotiomNotification object:nil];;
}


#pragma mark 手机拍照
-(void)takePhoto
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark 获取图库
-(void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark 处理图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    /**
     *  UIImagePickerControllerEditedImage = <UIImage: 0x7fba95824170> size {748, 496} orientation 0 scale 1.000000,
     UIImagePickerControllerReferenceURL = assets-library://asset/asset.JPG?id=31225C2F-1039-452B-8AD0-784A1A1A4836&ext=JPG,
     UIImagePickerControllerCropRect = NSRect: {{0, 0}, {2668, 1772}},
     UIImagePickerControllerMediaType = public.image,
     UIImagePickerControllerOriginalImage = <UIImage: 0x7fba958855a0> size {2668, 1772} orientation 0 scale 1.000000
     */
   
    //保存原始图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@",info);
    /**
     *  经过真机测试研究,这里的图片方向应该是根据重力感应获取的拍摄照片时的方向
     */
    switch (image.imageOrientation) {
        case UIImageOrientationUp:
            LCLogInfo(@"UIImageOrientation -- 上");
        break;
        case UIImageOrientationDown:
            LCLogInfo(@"UIImageOrientation -- 下");

        break;
        case UIImageOrientationLeft:
            LCLogInfo(@"UIImageOrientation -- 左");

        break;
        case UIImageOrientationRight:
            LCLogInfo(@"UIImageOrientation -- 右");
            
            //镜像后的方向
        case UIImageOrientationUpMirrored:
            LCLogInfo(@"UIImageOrientationUpMirrored -- 上");
        break;
        case UIImageOrientationDownMirrored:
            LCLogInfo(@"UIImageOrientationUpMirrored -- 下");
        break;
        case UIImageOrientationLeftMirrored:
            LCLogInfo(@"UIImageOrientationUpMirrored -- 左");
        break;
        case UIImageOrientationRightMirrored:
            LCLogInfo(@"UIImageOrientationUpMirrored -- 右");
        break;
        default:
            break;
    }
    [self.imageArray addObject:image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- test
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    
    // 键盘的frame
    CGFloat keyboardH = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self changeKeyboard_Y:(SCREEN_HEIGHT - keyboardH - self.myKeyboardToolBar.height - 100)];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    [self changeKeyboard_Y:(SCREEN_HEIGHT - self.myKeyboardToolBar.height)];
}
- (void)changeKeyboard_Y:(CGFloat)Y{
    // 执行动画
    [UIView animateWithDuration:0.25 animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        self.myKeyboardToolBar.y = Y;
    }];
    
}
@end

//
//  SendViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-12-24.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "SendViewController.h"
#import "UIFactory.h"
#import "NearByViewController.h"
#import "BaseNavigationViewController.h"
#import "ASINetDataService.h"

@interface SendViewController ()

@end

@implementation SendViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        self.isCancelButton = YES;
        self.isbackButton= NO;
    }
    return self;
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.title = @"发布微博";
    _buttons = [[NSMutableArray alloc] initWithCapacity:6];
   
    
     UIButton *sendButton = [UIFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"发送" target:self action:@selector(sendAction)];
    UIBarButtonItem *sendButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = [sendButtonItem autorelease];
    [self _initView];
    }
-(void)_initView{
    [self.textView becomeFirstResponder];
    NSArray *imageNames = [NSArray arrayWithObjects:@"compose_locatebutton_background.png",
                           @"compose_camerabutton_background.png",
                           @"compose_trendbutton_background.png",
                           @"compose_mentionbutton_background.png",
                           @"compose_emoticonbutton_background.png",
                           @"compose_keyboardbutton_background.png",
                           nil];
    
    NSArray *imageHighted = [NSArray arrayWithObjects:@"compose_locatebutton_background_highlighted.png",
                           @"compose_camerabutton_background_highlighted.png",
                           @"compose_trendbutton_background_highlighted.png",
                           @"compose_mentionbutton_background_highlighted.png",
                           @"compose_emoticonbutton_background_highlighted.png",
                            @"compose_keyboardbutton_background__highlighted.png",
                           nil];
    
    for (int i = 0; i < imageNames.count; i++) {
        NSString *imageName = [imageNames objectAtIndex:i];
        NSString *hightedName = [imageHighted objectAtIndex:i];
        UIButton *button = [UIFactory createButton:imageName highlighted:hightedName];
        [button setImage:[UIImage imageNamed:hightedName] forState:UIControlStateHighlighted];
        button.tag +=(10+i);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(20+(64*i) , 25, 23, 19);
        [self.editorBar addSubview:button];
        [_buttons addObject:button];
        if (i==5) {
            button.hidden = YES;
            button.left -= 64;
        }
    }
}


-(void)keyboardShowNotification:(NSNotification *)notification{
    
    NSLog(@"%@",notification.userInfo);
    NSValue *keyboardValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame= [keyboardValue CGRectValue];

    float height = frame.size.height;
    self.editorBar.bottom = ScreenHeight - height - 20 -14 -40;
  
    self.textView.height =self.editorBar.top;
    
}

-(void)location{
    NearByViewController *nearbyCtrl = [[NearByViewController alloc] init];
    BaseNavigationViewController *nearbyNav = [[BaseNavigationViewController alloc] initWithRootViewController:nearbyCtrl];
    [self presentModalViewController:nearbyNav animated:YES];
    [nearbyCtrl release];
    [nearbyNav release];
    nearbyCtrl.selectBlock = ^(NSDictionary *result){
        NSLog(@"%@",result);
    };
}
-(void)buttonAction:(UIButton *)button{
    if (button.tag == 10) {
        [self location];
    }else if (button.tag == 11){
        [self selectImage];
    }
}

#pragma mark -UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex==0) {
       BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
           UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if (buttonIndex == 2){
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
}

#pragma mark UIImagePickerControll delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    UIImage *image = (UIImageView *)[info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.sendImageButton==nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius =  5;
        button.layer.masksToBounds = YES;
        button.frame = CGRectMake(5, 20, 25, 25);
        [button addTarget:self action:@selector(imageAction) forControlEvents:UIControlEventTouchUpInside];
        self.sendImageButton = button;
    }
    [self.sendImageButton setImage:image forState:UIControlStateNormal];
    [self.editorBar addSubview:self.sendImageButton];
    UIButton *buttond1 = [_buttons objectAtIndex:0];
    UIButton *buttond2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:0.5 animations:^{
        buttond1.transform = CGAffineTransformTranslate(buttond1.transform, 20, 0);
         buttond2.transform = CGAffineTransformTranslate(buttond2.transform, 5, 0);
//        buttond2.transform = CGAffineTransformIdentity;
    }];
    self.sendImage = image;
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imageAction{
    if (_fullImageView==nil) {
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _fullImageView.backgroundColor = [UIColor blackColor];
        _fullImageView.userInteractionEnabled = YES;
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImageAction:)];
        [_fullImageView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        UIButton *deleteButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
        deleteButton.hidden = YES;
        deleteButton.tag = 100;
        deleteButton.frame = CGRectMake(280, 40, 20, 26);
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [_fullImageView addSubview:deleteButton];
    }
    [self.textView resignFirstResponder];
    if (![_fullImageView superview]) {
        _fullImageView.image = self.sendImage;
        [self.view.window addSubview:_fullImageView];
        _fullImageView.frame = CGRectMake(5, ScreenHeight-240, 20, 20);
        [UIView animateWithDuration:0.5 animations:^{
            _fullImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden =YES;
            [_fullImageView viewWithTag:100].hidden = NO;
        }];
    }
}

-(void)deleteAction:(UIButton *)deleteButton{
     [_fullImageView viewWithTag:100].hidden = YES;
    [self scaleImageAction:nil];
    [self.sendImageButton removeFromSuperview];
    self.sendImage = nil;
    UIButton *buttond1 = [_buttons objectAtIndex:0];
    UIButton *buttond2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:0.5 animations:^{
        buttond2.transform = CGAffineTransformIdentity;
        buttond1.transform = CGAffineTransformIdentity;
        
    }];
    
}
-(void)scaleImageAction:(UITapGestureRecognizer *)tap{
    [_fullImageView viewWithTag:100].hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
       _fullImageView.frame = CGRectMake(5, ScreenHeight-240, 20, 20);
    } completion:^(BOOL finished) {
        [_fullImageView removeFromSuperview];
        _fullImageView = nil;
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
    [self.textView becomeFirstResponder];
}

-(void)selectImage{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(void)doSendData{
    [super showStatusTip:YES title:@"发送中"];
    NSString *text = self.textView.text;
    if (text.length==0) {
        NSLog(@"微博内容为空");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:text forKey:@"status"];
    if (self.sendImage == nil) {
    [self.sinaweibo requestWithURL:@"statuses/update.json" params:params httpMethod:@"POST" block:^(id result){
//        [super showHud];
      
        [super showStatusTip:NO title:@"发送成功"];
         [self dismissModalViewControllerAnimated:YES];
       
    }];
    }else{
        NSData *data =UIImageJPEGRepresentation(self.sendImage, 0.3);
        [params setObject:data forKey:@"pic"];
        [ASINetDataService requestWithUrl:@"statuses/upload.json" params:params httpMethod:@"POST" completeBlock:^(id result) {
            [super showStatusTip:NO title:@"发送成功"];
            [self dismissModalViewControllerAnimated:YES];
        }];
//        [self.sinaweibo requestWithURL:@"statuses/upload.json" params:params httpMethod:@"POST" block:^(id result){
//            //        [super showHud];
//            
//            [super showStatusTip:NO title:@"发送成功"];
//           [self dismissModalViewControllerAnimated:YES];
//            
//        }];
    }
}
-(void)cancleAction{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)sendAction{
    [self doSendData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textView release];
    [_editorBar release];
    [super dealloc];
}
@end

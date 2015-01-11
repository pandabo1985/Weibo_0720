//
//  SendViewController.h
//  Weibo_0720
//
//  Created by pan dabo on 14-12-24.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "BaseViewController.h"

@interface SendViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSMutableArray *_buttons;
    UIImageView *_fullImageView;
}

@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UIView *editorBar;
@property (nonatomic, copy) UIImageView *sendImage;
@property (nonatomic, retain)UIButton *sendImageButton;

@end

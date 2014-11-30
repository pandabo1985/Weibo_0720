//
//  ImageModeControl.m
//  Weibo_0720
//
//  Created by pan dabo on 14-11-9.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "ImageModeControl.h"

@interface ImageModeControl ()

@end

@implementation ImageModeControl


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        imageModes= [NSArray arrayWithObjects:@"小图",@"大图", nil];
        [imageModes retain];
        self.title = @"图片模式";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark UITableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int mode = 0;
    if (indexPath.row==0) {
        mode = SmallBrowMode;
    }else if(indexPath.row ==1){
        mode = LargBrowMode;
    }
  
    //保存主题
    [[NSUserDefaults standardUserDefaults] setObject: [NSNumber numberWithInt:mode] forKey:kBrowMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //刷新列表
    [tableView reloadData];
}

#pragma mark  #UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imageModes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"themeCell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(10, 10, 200, 30);
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        textLabel.tag = 2013;
        [cell.contentView addSubview:textLabel];
        
    }
 
    
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2013];
    NSString *name =imageModes[indexPath.row];
    textLabel.text = name;
    int mode = [[NSUserDefaults standardUserDefaults] integerForKey:kBrowMode];
    if(mode == 0){
        mode = SmallBrowMode;
    }
    NSString *temp = imageModes [mode -1];
    if ([temp isEqualToString:name ]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)dealloc {
    [_tableview release];
    [super dealloc];
}
@end

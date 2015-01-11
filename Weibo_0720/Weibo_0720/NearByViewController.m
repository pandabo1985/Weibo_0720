//
//  NearByViewController.m
//  Weibo_0720
//
//  Created by pan dabo on 14-12-29.
//  Copyright (c) 2014年 afayear. All rights reserved.
//

#import "NearByViewController.h"
#import "UIImageView+WebCache.h"
#import "UIFactory.h"


@interface NearByViewController ()

@end

@implementation NearByViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isbackButton = NO;
        self.isCancelButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我在这里";
    
    self.tableView.hidden = YES;
    [super showLoading:YES];
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager startUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSString *address = [dic objectForKey:@"address"];
    NSString *icon = [dic objectForKey:@"icon"];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = address;
    [cell.imageView setImageWithURL:[NSURL URLWithString:icon]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectBlock!=nil) {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        _selectBlock(dic);
        Block_release(_selectBlock);
        _selectBlock = nil;
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)refreshUI{
    self.tableView.hidden = NO;
    [super showLoading:NO];
    [self.tableView reloadData];
}
-(void)loadNearByDataFinish:(NSDictionary *)result{
    NSArray *pois = [result objectForKey:@"pois"];
    self.data = pois;
    [self refreshUI];
}
#pragma mark loccation
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    [manager stopUpdatingLocation];

    if (self.data == nil) {
        float longitude=  newLocation.coordinate.longitude;
        float latitude=  newLocation.coordinate.latitude;
        NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
        NSString *latitudeStr  = [NSString stringWithFormat:@"%f",latitude];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:longitudeStr,@"long",latitudeStr,@"lat", nil];
        [self.sinaweibo requestWithURL:@"place/nearby/pois.json" params:params httpMethod:@"GET" block:^(id resul){
            NSLog(@"%@",resul);
            [self loadNearByDataFinish:resul];
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    self.tableView.hidden = NO;
    [super showLoading:NO];
    NSLog(@"%@",error);
}
- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end

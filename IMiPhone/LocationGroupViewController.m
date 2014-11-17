//
//  LocationGroupViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LocationGroupViewController.h"

@interface LocationGroupViewController ()

@end

@implementation LocationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //开始定位
    [self startUpdatingLocation:self];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 停止定位
    [self stopUpdatingLocation];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goBackTouchUp:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回");
    }];
}
@end

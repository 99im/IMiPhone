//
//  EmotionViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "EmotionViewController.h"
#import "ChatDataProxy.h"

@interface EmotionViewController () <UIScrollViewDelegate>

@property (nonatomic) NSInteger nPages;

@end

@implementation EmotionViewController

NSInteger const EMOTS_PAGENUM = 4;
float const EMOTS_HEIGHT = 240.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nPages = ([ChatDataProxy sharedProxy].arrEmotions.count + EMOTS_PAGENUM - 1) / EMOTS_PAGENUM;
    self.pageControl.numberOfPages = self.nPages;
    
    self.arrPageViewController = [[NSMutableArray alloc] initWithCapacity:self.nPages];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.nPages, self.scrollView.frame.size.height);
    self.scrollView.frame = self.view.frame;
    
    EmotIconViewController *pageViewController;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    for (int i = 0; i < self.nPages; i++) {
        pageViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"EmotIconViewController"];
        [pageViewController initEmotIcons:[ChatDataProxy sharedProxy].arrEmotions fromIndex:i * EMOTS_PAGENUM toIndex:MIN([ChatDataProxy sharedProxy].arrEmotions.count - 1, i * EMOTS_PAGENUM + EMOTS_PAGENUM - 1)];
        pageViewController.view.frame = CGRectMake(self.view.frame.size.width * i, 0.0f, self.view.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:pageViewController.view];
        [self addChildViewController:pageViewController];
        [self.arrPageViewController addObject:pageViewController];
    }
    
    self.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pageControlValueChanged:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width * whichPage, 0.0f);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    CGPoint offset = aScrollView.contentOffset;
    self.pageControl.currentPage = offset.x / self.view.frame.size.width;
}

@end

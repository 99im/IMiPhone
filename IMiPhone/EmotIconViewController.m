//
//  EmotIconViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "EmotIconViewController.h"
#import "EmotionViewController.h"

@interface EmotIconViewController ()

@property (strong, nonatomic) NSMutableArray *arrEmotButtons;

@end

@implementation EmotIconViewController

@synthesize page;

float const STARTX = 10.0f;
float const STARTY = 10.0f;
float const OFFSETX = 50.0f;
float const OFFSETY = 50.0f;
NSInteger const COLUMN = 6;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initEmotIcons:(NSArray *)emots fromIndex:(NSInteger)start toIndex:(NSInteger)end
{
    UIButton *button = nil;
    NSDictionary *dicEmot = nil;
    UIImage *image = nil;
    NSInteger index;
    self.arrEmotButtons = [NSMutableArray arrayWithCapacity:end - start + 1];
    for (NSInteger i = start; i <= end; i++) {
        index = i - start;
        dicEmot = [emots objectAtIndex:i];
        image = [UIImage imageNamed:[dicEmot objectForKey:@"image"]];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(STARTX + (index % COLUMN) * OFFSETX, STARTY + (index / COLUMN) * OFFSETY, image.size.width, image.size.height);
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(emotIconTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.arrEmotButtons addObject:button];
    }
}

- (void)emotIconTouchUpInside:(id)sender
{
    NSInteger index = [self.arrEmotButtons indexOfObject:sender];
    NSLog(@"Emotion Icon touched! index: %li", (long)index);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_EMOTION_SELECTED object:[NSIndexPath indexPathForRow:index inSection:self.page]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnDelTouchUpInside:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_EMOTION_DELETE object:nil];
}

- (IBAction)btnSendTouchUpInside:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_EMOTION_SEND object:nil];
}
@end

//
//  ProfileViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ProfileViewController.h"
#import "imUtil.h"
#import "LoginViewController.h"

@interface ProfileViewController () <UIGestureRecognizerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) UITapGestureRecognizer *tap;

@end

@implementation ProfileViewController

@synthesize tap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];

    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.view removeGestureRecognizer:tap];
    tap = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tapHandler:(UITapGestureRecognizer *)sender
{
    NSLog(@"Gesture Recognize: imgHead");
    CGPoint point = [sender locationInView:self.imgHead];
    if ([imUtil checkPoint:point inRectangle:[self.imgHead bounds]]) {
        NSLog(@"tapHandler: x: %f, y: %f", point.x, point.y);
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        [choiceSheet showInView:[self.view superview]];
    }
}

- (BOOL)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 拍照
//        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
//            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//            if ([self isFrontCameraAvailable]) {
//                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//            }
//            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//            controller.mediaTypes = mediaTypes;
//            controller.delegate = self;
//            [self presentViewController:controller
//                               animated:YES
//                             completion:^(void){
//                                 NSLog(@"Picker View Controller is presented");
//                             }];
//        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

@end

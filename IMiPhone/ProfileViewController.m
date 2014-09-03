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
#import "imPhotoPicker.h"

@interface ProfileViewController () <UIGestureRecognizerDelegate, VPImageCropperDelegate>

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

- (void)tapHandler:(UITapGestureRecognizer *)sender
{
    NSLog(@"Gesture Recognize: imgHead");
    CGPoint point = [sender locationInView:self.imgHead];
    if ([imUtil checkPoint:point inRectangle:[self.imgHead bounds]]) {
        NSLog(@"tapHandler: x: %f, y: %f", point.x, point.y);
        [[imPhotoPicker sharedPicker] showChoiceSheet:self inView:[self.view superview]];
    }
}

- (BOOL)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    //self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [self.imgHead setImage:editedImage];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

@end

//
//  AudioRecordManager.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AudioRecordManager.h"
@interface AudioRecordManager()
@property AVAudioRecorder *recorder;
@property NSURL *urlPlay;
@property (retain, nonatomic) AVAudioPlayer *avPlay;
@end

@implementation AudioRecordManager
@synthesize avPlay = _avPlay;

static AudioRecordManager *sharedAudioRecordManager;
+(AudioRecordManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedAudioRecordManager = [[AudioRecordManager alloc] init];
        [sharedAudioRecordManager initRecorder];
    });
    return sharedAudioRecordManager;
}
-(void)initRecorder{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac", strUrl]];
    self.urlPlay = url;
    
    NSError *error;
    //初始化
    self.recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    self.recorder.meteringEnabled = YES;
    self.recorder.delegate = self;
}
//开始录音
-(int)start{
    //创建录音文件，准备录音
    if ([self.recorder prepareToRecord]) {
        //开始
        [self.recorder record];
    }
    return 0;
}
//结束录音，返回录音存放路径
-(int)end{
    [self.recorder stop];
    return 0;
}
//播放指定路径声音文件
-(int)play{
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return -1;
    }
    self.avPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:self.urlPlay error:nil];
    [self.avPlay play];
    return 0;
}

@end

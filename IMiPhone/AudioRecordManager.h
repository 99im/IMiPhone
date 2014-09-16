//
//  AudioRecordManager.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>


@interface AudioRecordManager : NSObject <AVAudioRecorderDelegate>

+ (AudioRecordManager*)sharedManager;
//开始录音
-(int)start;
//结束录音，返回录音存放路径
-(int)end;
//播放录下的声音文件
-(int)play;
@end

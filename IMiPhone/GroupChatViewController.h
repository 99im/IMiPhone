//
//  GroupChatViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMNWProxyProtocol.h"

@interface GroupChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, IMNWProxyProtocol>

- (IBAction)tfInputTextDidEndOnExit:(id)sender;

@end

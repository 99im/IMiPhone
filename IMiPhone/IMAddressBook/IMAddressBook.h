//
//  IMAddressBook.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-15.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "IMAddressPerson.h"

@interface IMAddressBook : NSObject

+ (void)getUserAddressBook;

+ (void)constructInThread:(ABAddressBookRef)ab;


@end

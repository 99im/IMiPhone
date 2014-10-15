//
//  IMAddressBook.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-15.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMAddressBook.h"


@implementation IMAddressBook

//获取通讯录
+ (void)getUserAddressBook
{
    //获取通讯录权限
    ABAddressBookRef ab = NULL;
    // ABAddressBookCreateWithOptions is iOS 6 and up.
    if (&ABAddressBookCreateWithOptions) {
        CFErrorRef error = nil;
        ab = ABAddressBookCreateWithOptions(NULL, &error);
        
        if (error) { NSLog(@"%@", error); }
    }
    if (ab == NULL) {
        ab = ABAddressBookCreate();
    }
    if (ab) {
        // ABAddressBookRequestAccessWithCompletion is iOS 6 and up. 适配IOS6以上版本
        if (&ABAddressBookRequestAccessWithCompletion) {
            ABAddressBookRequestAccessWithCompletion(ab,
                                                     ^(bool granted, CFErrorRef error) {
                                                         if (granted) {
                                                             // constructInThread: will CFRelease ab.
                                                             [NSThread detachNewThreadSelector:@selector(constructInThread:)
                                                                                      toTarget:self
                                                                                    withObject:CFBridgingRelease(ab)];
                                                         } else {
                                                             //                                                             CFRelease(ab);
                                                             // Ignore the error
                                                             NSLog(@"not granted!");
                                                         }
                                                     });
        } else {
            // constructInThread: will CFRelease ab.
            [NSThread detachNewThreadSelector:@selector(constructInThread:)
                                     toTarget:self
                                   withObject:CFBridgingRelease(ab)];
        }
    }
}

//获取到addressbook的权限
+ (void)constructInThread:(ABAddressBookRef)ab
{
    NSLog(@"we got the access right");
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(ab);
    NSMutableArray* contactArray = [[NSMutableArray alloc]init];
    for(int i = 0; i < CFArrayGetCount(results); i++)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        //构造联系人数据
        IMAddressPerson *adrressPerson = [[IMAddressPerson alloc] init];
        adrressPerson.firstName = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));;
//        adrressPerson.lastName = lastname;
//        //姓
//        NSString *firstName =
//        //姓音标
//        //        NSString *firstNamePhonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty));
//        //名
//        NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        //名音标
        //        NSString *lastnamePhonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty));
        //公司
        NSString *Organization = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonOrganizationProperty));
        //读取jobtitle工作
        //        NSString *jobtitle = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonJobTitleProperty));
        //读取department部门
        NSString *department = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonDepartmentProperty));
        //读取birthday生日
        NSDate *birthday = (NSDate*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonBirthdayProperty));
        //读取nickname呢称
        double birthdayString = [birthday timeIntervalSince1970];
        NSString *nickname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonNicknameProperty));
        //读取电话多值
        NSString* phoneString = @"";
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            //            NSString * personPhoneLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k)));
            //获取該Label下的电话值
            NSString * personPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k));
            phoneString = [phoneString stringByAppendingFormat:@",%@",personPhone];
            personPhone = nil;
            
        }
        CFRelease(phone);
        //获取email多值
        NSString* emailString = @"";
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        int emailcount = ABMultiValueGetCount(email);
        for (int x = 0; x < emailcount; x++)
        {
            //获取email Label
            //            NSString* emailLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x)));
            //获取email值
            NSString* emailContent = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(email, x));
            emailString = [emailString stringByAppendingFormat:@",%@",emailContent];
            emailContent = nil;
        }
        CFRelease(email);
        
        //获取URL多值
        NSString* urlString = @"";
        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
        for (int m = 0; m < ABMultiValueGetCount(url); m++)
        {
            //获取电话Label
            //            NSString * urlLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m)));
            //获取該Label下url值
            NSString * urlContent = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(url,m));
            urlString = [urlString stringByAppendingFormat:@",%@",urlContent];
            urlContent = nil;
        }
        CFRelease(url);
        
       
//        NSDictionary* dic = @{@"first_name": firstName?firstName:[NSNull null],
//                              @"last_name": lastname?lastname:[NSNull null],
//                              @"home_phone": phoneString?phoneString:[NSNull null],
//                              @"email": emailString?emailString:[NSNull null],
//                              @"company": Organization?Organization:[NSNull null],
//                              @"nick_name": nickname?nickname:[NSNull null],
//                              @"department": department?department:[NSNull null],
//                              @"birthday": [NSNumber numberWithDouble:birthdayString],
//                              @"blog_index": urlString?urlString:[NSNull null]
//                              };
//        [contactArray addObject:dic];
        emailString = nil;
        urlString = nil;
        phoneString = nil;
    }
    CFRelease(results);
    contactArray = nil;  
    
}


@end

//
//  ViewController.h
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/21.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZITOPay.h"
@interface ViewController : UIViewController
@property (nonatomic,retain) NSDictionary *dicData;

@property (strong, nonatomic) ZITOBaseResp *orderList;

@property  (assign, nonatomic) NSInteger actionType;
@end


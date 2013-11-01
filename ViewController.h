//
//  ViewController.h
//  IAPpurchaseDemo
//
//  Created by shangxiaonan on 13-11-1.
//  Copyright (c) 2013年 Renjiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InAppPurchaseManager.h"
@class InAppPurchaseManager;

@interface ViewController : UIViewController
{
    InAppPurchaseManager *purchaseDelegate;
}
@end


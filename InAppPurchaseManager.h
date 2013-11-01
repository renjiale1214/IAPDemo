//
//  InAppPurchaseManager.h
//  IAPpurchaseDemo
//
//  Created by shangxiaonan on 13-11-1.
//  Copyright (c) 2013年 Renjiale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
enum
{
    mami100Six = 6,
    mami100Twelve = 12,
    mami100TwentyFour = 25,
    mami100Thirty = 30,
}tuwenzixun;
@interface InAppPurchaseManager : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    int buyType;
    SKProductsRequest *request;
}
-(void) buy:(int) buy;
@end


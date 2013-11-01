//
//  InAppPurchaseManager.m
//  IAPpurchaseDemo
//
//  Created by shangxiaonan on 13-11-1.
//  Copyright (c) 2013年 Renjiale. All rights reserved.
//

#import "InAppPurchaseManager.h"
#define ProductIDmami100six        @"com.mami100.sxyuan6"
#define ProductIDmami100twelve     @"com.mami100.sxyuan12"
#define ProductIDmami100twentyfour @"com.mami100.sxyuan25"
#define ProductIDmami100thirty     @"com.mami100.sxyuan30"
@implementation InAppPurchaseManager

-(id)init
{
    if(self=[super init])
    {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(void) buy:(int) buy//go to RequestProductData
{
    buyType = buy;
    if ([SKPaymentQueue canMakePayments]) {
        [self RequestProductData];
        NSLog(@"允许程序内购买");
        //风火轮？？
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"不允许应用内购买" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        NSLog(@"不允许应用内购买,请开启购买");
        [alert show];
    }
}

-(void) RequestProductData// go to ProductRequest:didReceiveResponse
{
    NSLog(@"=======请求对应的产品信息=======");
    NSArray *product = nil;
    switch (buyType) {
        case mami100Six:
            product = [[NSArray alloc] initWithObjects:ProductIDmami100six, nil];
            break;
        case mami100Twelve:
            product = [[NSArray alloc] initWithObjects:ProductIDmami100twelve, nil];
            break;
        case mami100TwentyFour:
            product = [[NSArray alloc] initWithObjects:ProductIDmami100twentyfour, nil];
            break;
        case mami100Thirty:
            product = [[NSArray alloc] initWithObjects:ProductIDmami100thirty, nil];
            break;
        default:
            break;
    }
    NSSet *nsset = [NSSet setWithArray:product];
    request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}
-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response //go to paymentQueue:updatedTransactions:
{
    NSLog(@"========收到产品反馈信息=========");
    NSArray *myProduct = response.products;
    NSLog(@"产品ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %i", [myProduct count]);
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
    }
    SKPayment *payment = nil;
    switch (buyType) {
        case mami100Six:
            payment = [SKPayment paymentWithProduct:[response.products objectAtIndex:0]];
            break;
        case mami100Twelve:
            payment = [SKPayment paymentWithProduct:[response.products objectAtIndex:0]];
            break;
        case mami100TwentyFour:
            payment = [SKPayment paymentWithProduct:[response.products objectAtIndex:0]];
            break;
        case mami100Thirty:
            payment = [SKPayment paymentWithProduct:[response.products objectAtIndex:0]];
            break;
        default:
            break;
    }
    NSLog(@"=======发送购买请求=======");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    //这里添加风火轮？？
}

-(void) requestProUpgradeProductData
{
    NSLog(@"=======请求数据升级=======");
    NSSet *productIdentifier = [NSSet setWithObject:@"com.productid"];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifier];
    productsRequest.delegate = self;
    [productsRequest start];
}

-(void) request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"=======弹出错误信息=======");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert", NULL) message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"close", nil) otherButtonTitles: nil];
    [alert show];
}

-(void) requestDidFinish:(SKRequest *)request //调用StoreKit中的方法，交给苹果自己去处理，然后再返回paymentQueue:updatedTransactions:
{
    NSLog(@"=======反馈信息结束======");
    //风火轮？？
}

-(void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions //go to requestDidFinish
{
    NSLog(@"=======paymentQueue=======%i",[transactions count]);//再次回到这里之后go to completeTransaction:
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                [self completeTransaction:transaction];//是因为这里要求go tocompleteTransaction:的
                NSLog(@"=======交易完成=======");
                UIAlertView *alertPurchased = [[UIAlertView alloc] initWithTitle:@"交易成功" message:@"您已经成功购买了本产品" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                [alertPurchased show];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"=======交易失败=======");
                UIAlertView *alertFailed = [[UIAlertView alloc] initWithTitle:@"交易失败" message:@"交易失败，请尝试重新购买" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                [alertFailed show];
                [self failedTransaction:transaction];//如果交易失败就go to failedTransaction:
            }
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"=======已经购买过=======");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"=======将产品添加至列表=======");
                break;
            default:
                break;
        }
    }
}

-(void) completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"=======completeTransaction=======");
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *productid = [tt lastObject];//这里取出的string是com.tuwenzixun.mami100.sixyuan中的“sixyuan”
        if ([productid length] > 0) {
            [self recordTransaction:productid];//go to recordTransaction:
            [self provideContent:productid];//go to provideContent:
        }
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


//记录交易
-(void)recordTransaction:(NSString *)product{
    NSLog(@"=======记录交易=======");
    NSLog(@"%@",product);
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    NSLog(@"=======下载内容=======");
    NSLog(@"%@",product);
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
}

-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];

}

@end


//
//  ViewController.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/21.
//  Copyright © 2016年 ldd. All rights reserved.
//项目上线日期2016年11月8日

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
@interface ViewController ()<UIWebViewDelegate,ZITOPayDelegate>

@property (nonatomic,strong)UIWebView *webView;
@end

@implementation ViewController

#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubview];
    [self loadWebview];
}
- (void)addSubview {
    [self.view addSubview:self.webView];
}

#pragma mark WKWebview和UIWebview懒加载
- (UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark iOS7和iOS8 webview使用
- (void)loadWebview
{
    NSString *urlString = [[NSBundle mainBundle]pathForResource:@"test.html" ofType:nil];
    if (!urlString) {
        return;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.webView loadRequest:req];
}

#pragma mark UIWebviewJS与OC交互
/*
 *js调用oc方法
 */
//UIWebview网页加载完成时调用   ----documentView.webView.mainFrame.javaScriptContext----不支持WKWebview
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self webviewjsWithOcAction];
    
}
/*
 *js调用oc方法
 */
- (void)webviewjsWithOcAction
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //    __weak typeof(self) weakSelf = self;
    context[@"zitopay"] = ^() {
        
        //获取参数
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 1) {
            return ;
        }
        NSDictionary *tempDic = [args[0] toDictionary];
        NSString *ordertitle = [tempDic objectForKey:@"ordertitle"];
        NSString *totalPrice = [tempDic objectForKey:@"totalPrice"];
        NSInteger bill_timeout  = [[tempDic objectForKey:@"bill_timeout"]integerValue];
        NSInteger channel = [[tempDic objectForKey:@"channel"]integerValue];
        NSString *orderidinf = [tempDic objectForKey:@"orderidinf"];
        NSString *currency = [tempDic objectForKey:@"currency"];
        NSString *scheme = [tempDic objectForKey:@"scheme"];
        NSString *goodsname = [tempDic objectForKey:@"goodsname"];
        NSString *goodsdetail = [tempDic objectForKey:@"goodsdetail"];
        NSInteger cardType = [[tempDic objectForKey:@"cardType"]integerValue];
        NSString *bgRetUrl = [tempDic objectForKey:@"bgRetUrl"];
        NSString *idCard = [tempDic objectForKey:@"idCard"];
        //赋值  channel
        ZITOPayReq *payReq = [[ZITOPayReq alloc]init];
        payReq.title = ordertitle;
        payReq.totalFee = totalPrice;
        payReq.channel = channel;//数字
        payReq.billNo = orderidinf;
        payReq.billTimeOut = bill_timeout;
        payReq.viewController = self;
        payReq.currency = currency;
        payReq.scheme = scheme;
        payReq.goodsname = goodsname;
        payReq.goodsdetail = goodsdetail;
        payReq.cardType = cardType;
        payReq.bgRetUrl = bgRetUrl;
        payReq.idCard = idCard;
        [ZITOPay sendZITOReq:payReq];
    };
}
- (void)viewWillAppear:(BOOL)animated
{   //设置delegate回调
    [super viewWillAppear:animated];
    [ZITOPay setZITOPayDelegate:self];
}

#pragma mark ZITOPayDelegate实现代理方法
- (void)onZITOPayResp:(ZITOBaseResp *)resp {
    //OC调用js
    NSString *jsStr = [NSString stringWithFormat:@"payResult('%@')",resp.resultMsg];
    [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
}

- (void)dealloc {
    _webView = nil;
}

@end

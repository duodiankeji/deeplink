//
//  WebViewController.m
//  Pods
//
//  Created by mkoo on 2017/3/14.
//
//

#import "WebViewController.h"

@interface WebViewController ()
@end


@implementation WebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close:)]];
    
    UIWebView *webView = [UIWebView new];
    webView.frame = [UIScreen mainScreen].bounds;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:webView];
    
    NSMutableArray * tempConstraints = [NSMutableArray array];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[webView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(webView)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[webView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(webView)]];
    [self.view addConstraints:tempConstraints];
}

- (IBAction)close:(id)sender {
    if([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController*)self.parentViewController) popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

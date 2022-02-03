//
//  ZhuceViewController.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "ZhuceViewController.h"

@interface ZhuceViewController ()

@end

@implementation ZhuceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.zhuceView=[[ZhuceView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.zhuceView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

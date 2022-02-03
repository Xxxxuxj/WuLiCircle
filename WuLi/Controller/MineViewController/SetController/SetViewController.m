//
//  SetViewController.m
//  WuLi
//
//  Created by Mac on 2021/12/1.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.setView=[[SetView alloc]initWithFrame:self.view.frame];
    CGFloat red=230.0/256.0;
    CGFloat green=230.0/256.0;
    CGFloat blue=230.0/256.0;
    self.setView.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    [self.view addSubview:self.setView];
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

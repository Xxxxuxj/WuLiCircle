//
//  ReleaseCircleViewController.m
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import "ReleaseCircleViewController.h"

@interface ReleaseCircleViewController ()

@end

@implementation ReleaseCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(circleKeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(circleKeyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertCircleNoTitle) name:@"alertCircleNoTitle" object:nil];
    
    
    
    
    // Do any additional setup after loading the view.
    self.releaseCircleView=[[ReleaseCircleView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.releaseCircleView];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

*/


-(void)layoutWithImageArray:(NSArray *)imgArray{
    [_releaseCircleView updateImageArray:imgArray];
}

-(void)alertCircleNoTitle{
    
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"标题不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:NO completion:nil];
}

-(void)circleKeyboardWillShow{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addCircleGestureRecognizer" object:nil];
}

-(void)circleKeyboardWillHide{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeCircleGestureRecognizer" object:nil];
    
}

@end

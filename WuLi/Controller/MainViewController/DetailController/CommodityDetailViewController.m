//
//  CommodityDetailViewController.m
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import "CommodityDetailViewController.h"

@interface CommodityDetailViewController ()

@end

@implementation CommodityDetailViewController
-(instancetype)initWithModel:(CommodityModel *)model{
    self=[super init];
    self.model=model;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailView=[[CommodityView alloc]initWithFrame:self.view.frame model:self.model];
    [self.view addSubview:self.detailView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)keyboardShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.origin.y;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"resetCommentViewFrame" object:nil userInfo:@{@"Y":[NSString stringWithFormat:@"%d",height]}];
}



@end

//
//  UserViewController.m
//  WuLi
//
//  Created by Mac on 2022/1/21.
//

#import "UserViewController.h"

@interface UserViewController ()

@property (nonatomic)NSString *userID;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userView=[[UserView alloc]initWithFrame:CGRectMake(0,-1, self.view.frame.size.width, self.view.frame.size.height)];
    [_userView layoutWithUserID:self.userID];
    [self.view addSubview:_userView];
}

- (void)layoutWithUserID:(NSString *)ID{
    self.userID=ID;
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

//
//  RegisterViewController.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registerView=[[RegisterView alloc]initWithFrame:self.view.frame];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushWaitRegiserUserView) name:@"pushWaitRegisterUserView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popWaitRegiserUserView) name:@"popWaitRegisterUserView" object:nil];
    [self.view addSubview:self.registerView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)pushWaitRegiserUserView{
    Dialog()
    .wLoadingColorSet(DialogColor(0xFF9900))
    .wTitleSet(@"登录中...")
    .wTypeSet(DialogTypeLoading)
    .wLoadingTypeSet(LoadingStyleWait)
    .wShadowAlphaSet(0.01)
    .wShowCloseSet(NO)
    .wHideAnimationSet(AninatonHideNone)
    .wAnimationDurtionSet(1)
    .wLoadingSizeSet(CGSizeMake(50, 50))
    .wTagSet(222)
    .wStart();
}

-(void)popWaitRegiserUserView{
    [WMZDialog closeWithshowView:self.registerView block:nil];
}


@end

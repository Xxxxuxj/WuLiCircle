//
//  ReleaseCommodityViewController.m
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import "ReleaseCommodityViewController.h"

@interface ReleaseCommodityViewController ()

@end

@implementation ReleaseCommodityViewController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alertWarning" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alertWarningNoTitle" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alertWarningNoImage" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alertWarningNoLocation" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alertWarningNoPrice" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"alertLocationChoose" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertWarning) name:@"alertWarning" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertWarningNoTitle) name:@"alertWarningNoTitle" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertWarningNoImage) name:@"alertWarningNoImage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertWarningNoLocation) name:@"alertWarningNoLocation" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertWarningNoPrice) name:@"alertWarningNoPrice" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertLocationChoose) name:@"alertLocationChoose" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    UITapGestureRecognizer *singleTapGR =
//    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
//    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
//    [nc addObserverForName:UIKeyboardWillShowNotification
//                        object:nil
//                         queue:mainQuene
//                    usingBlock:^(NSNotification *note){
//                        [self.releaseView.imgCollectionView addGestureRecognizer:singleTapGR];
//                    }];
//    [nc addObserverForName:UIKeyboardWillHideNotification
//                        object:nil
//                         queue:mainQuene
//                    usingBlock:^(NSNotification *note){
//                        [self.releaseView.imgCollectionView removeGestureRecognizer:singleTapGR];
//                    }];


    
    
    self.view.backgroundColor=[UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    self.releaseView=[[ReleaseCommodityView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:self.releaseView];
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
    [_releaseView updateImageArray:imgArray];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.origin.y;
    _releaseView.keyboardY=height;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addGestureRecognizer" object:nil];
}


-(void)keyboardWillHide:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeGestureRecognizer" object:nil];
}




-(void)alertWarning{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"??????????????????9?????????" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:NO completion:nil];
    
}





-(void)alertWarningNoTitle{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"??????????????????" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:NO completion:nil];
}



-(void)alertWarningNoImage{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"??????????????????" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:NO completion:nil];
}

-(void)alertWarningNoLocation{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"???????????????" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:NO completion:nil];
}

-(void)alertWarningNoPrice{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"??????????????????" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:NO completion:nil];
}








-(void)alertLocationChoose{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionA=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    UIAlertAction *actionB=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setLocation" object:nil userInfo:@{@"location":@"??????"}];
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    UIAlertAction *actionC=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setLocation" object:nil userInfo:@{@"location":@"??????"}];
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    UIAlertAction *actionD=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setLocation" object:nil userInfo:@{@"location":@"??????"}];
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    UIAlertAction *actionE=[UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setLocation" object:nil userInfo:@{@"location":@"??????"}];
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    UIAlertAction *actionF=[UIAlertAction actionWithTitle:@"?????????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setLocation" object:nil userInfo:@{@"location":@"?????????"}];
        [controller dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [controller addAction:actionA];
    [controller addAction:actionB];
    [controller addAction:actionC];
    [controller addAction:actionD];
    [controller addAction:actionE];
    [controller addAction:actionF];
    
    
    [self presentViewController:controller animated:NO completion:nil];
}




@end

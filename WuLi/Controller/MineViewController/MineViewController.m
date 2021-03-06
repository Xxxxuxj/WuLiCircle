//
//  MineViewController.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "MineViewController.h"

@interface MineViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MineViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    [self.navigationController.navigationBar setHidden:YES];


    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushRegisterViewController) name:@"pushRegisterViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancleRegisterViewController) name:@"cancleRegisterViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushZhuceViewController) name:@"pushZhuceViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancleZhuceViewController) name:@"cancleZhuceViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(headImagePick) name:@"headImagePick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushSetViewController) name:@"pushSetViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitUser) name:@"exitUser" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushStarViewController) name:@"pushStarViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushHistoryViewController) name:@"pushHistoryViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushMyIssueViewController) name:@"pushMyIssueViewController" object:nil];
    // Do any additional setup after loading the view.

    self.mineView=[[MineView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.mineView layoutWihtLocalData];
    [self.view addSubview:self.mineView];
}


-(void) viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.userInteractionEnabled=NO;
//    [self.navigationController.navigationBar setHidden:YES];
//
//
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushRegisterViewController) name:@"pushRegisterViewController" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancleRegisterViewController) name:@"cancleRegisterViewController" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushZhuceViewController) name:@"pushZhuceViewController" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancleZhuceViewController) name:@"cancleZhuceViewController" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(headImagePick) name:@"headImagePick" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushSetViewController) name:@"pushSetViewController" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitUser) name:@"exitUser" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushStarViewController) name:@"pushStarViewController" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushHistoryViewController) name:@"pushHistoryViewController" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushMyIssueViewController) name:@"pushMyIssueViewController" object:nil];
//    // Do any additional setup after loading the view.
//
//    self.mineView=[[MineView alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.mineView layoutWihtLocalData];
//    [self.view addSubview:self.mineView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)pushRegisterViewController{
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
    
}

-(void)cancleRegisterViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushZhuceViewController{
    [self.navigationController pushViewController:[ZhuceViewController new] animated:YES];
}

-(void)cancleZhuceViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)headImagePick{
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"?????????????????????" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        
        // ????????????????????????
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)  {
                // ???????????????
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            [alertSheet addAction:cameraAction];
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"?????????????????????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            [alertSheet addAction:photoAction];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleCancel handler:nil];
        [alertSheet addAction:cancelAction];
        [self presentViewController:alertSheet animated:YES completion:nil];
}

-(void)pushSetViewController{
    [self.navigationController pushViewController:[SetViewController new] animated:YES];
    /*
     push??????viewcontroller?????? self.navigationController.navigationBar.userInteractionEnabled=NO;
     ???????????????YES
     */
    
    
    
    //[self.navigationController presentViewController:[SetViewController new] animated:YES completion:nil];
}

-(void)exitUser{
    [UserDefaults deleteUser];
    [UserDefaults deleteImage];
    [self.mineView layoutWihtLocalData];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushStarViewController{
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}

-(void)pushHistoryViewController{
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}

-(void)pushMyIssueViewController{
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // ??????????????????
    if ([mediaType isEqualToString:@"public.image"])   {
        // ????????????
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSString *path = [self saveImg:image WithName:@"headImage.png"];
        if (path != nil)  {
            // ????????????????????????????????????
            NSData *data = [NSData dataWithContentsOfFile:path];
            [UserDefaults deleteImage];
            [UserDefaults setImage:data];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"setHeadImage" object:nil userInfo:@{@"path":path}];
            
            
            
            NSData *imgDataCompression=[[UIImage imageWithContentsOfFile:path] compressQualityWithMaxLength:100];
            NSData *imgData=UIImagePNGRepresentation([UIImage imageWithContentsOfFile:path]);
            
            [UserDefaults setImage:imgDataCompression];
            
            NSLog(@"%@ --- %@",imgData,imgDataCompression);
            
            BmobFile *file=[[BmobFile alloc]initWithFileName:@"headImage.png" withFileData:imgData];
            BmobFile *fileCompression=[[BmobFile alloc]initWithFileName:@"headImage-C.jpg" withFileData:imgDataCompression];
            
                
            __block BmobObject *obj=[BmobObject new];
                
            BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
            [bquery getObjectInBackgroundWithId:[UserDefaults getUser].userId block:^(BmobObject *object, NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }else{
                    obj=object;
                    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
                        if(isSuccessful){
                            [obj setObject: file.url forKey:@"headImageUrl"];
                            [obj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                if(isSuccessful){

                                }
                            }];
                        }else{
                                //Error Domain=cn.bmob.www Code=10007 "?????????????????????????????????-?????????????????????????????????" UserInfo={NSLocalizedDescription=?????????????????????????????????-?????????????????????????????????}
                        }
                    }];
                    [fileCompression saveInBackground:^(BOOL isSuccessful, NSError *error) {
                        if(isSuccessful){
                            [obj setObject: fileCompression.url forKey:@"headImageUrl-C"];
                            NSLog(@"%@",fileCompression.url);
                            [obj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                if(isSuccessful){

                                }
                            }];
                        }else{
                                //Error Domain=cn.bmob.www Code=10007 "?????????????????????????????????-?????????????????????????????????" UserInfo={NSLocalizedDescription=?????????????????????????????????-?????????????????????????????????}
                        }
                    }];
                }
            }];
                
                

        }
        [picker dismissViewControllerAnimated:YES completion:nil];          // ????????????
    }
}
// ??????????????????

- (NSString *)saveImg:(UIImage *)curImage WithName:(NSString *)imageName;
{
    NSData *imageData = UIImageJPEGRepresentation(curImage, 1);             // 1???????????????????????????(0~1)
    
    // ??????????????????
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:imageName];
    
    // ?????????????????????
    //atomically????????????????????????: ?????????YES?????????????????????????????????,???????????????????????????????????????,?????????????????????????????????????????????????????????.?????????NO,??????????????????????????????
    if ([imageData writeToFile:path atomically:NO]) {
        return path;
    }  else {
        return nil;
    }
}

@end

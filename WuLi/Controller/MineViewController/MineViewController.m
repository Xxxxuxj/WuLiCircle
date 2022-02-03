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
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        
        // 判断是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)  {
                // 设置数据源
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            [alertSheet addAction:cameraAction];
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            [alertSheet addAction:photoAction];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertSheet addAction:cancelAction];
        [self presentViewController:alertSheet animated:YES completion:nil];
}

-(void)pushSetViewController{
    [self.navigationController pushViewController:[SetViewController new] animated:YES];
    /*
     push一个viewcontroller之后 self.navigationController.navigationBar.userInteractionEnabled=NO;
     会重新回到YES
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
    // 被选中的图片
    if ([mediaType isEqualToString:@"public.image"])   {
        // 获取照片
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSString *path = [self saveImg:image WithName:@"headImage.png"];
        if (path != nil)  {
            // 图片存在，做你想要的操作
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
                                //Error Domain=cn.bmob.www Code=10007 "开通文件服务前请到设置-域名管理处绑定文件域名" UserInfo={NSLocalizedDescription=开通文件服务前请到设置-域名管理处绑定文件域名}
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
                                //Error Domain=cn.bmob.www Code=10007 "开通文件服务前请到设置-域名管理处绑定文件域名" UserInfo={NSLocalizedDescription=开通文件服务前请到设置-域名管理处绑定文件域名}
                        }
                    }];
                }
            }];
                
                

        }
        [picker dismissViewControllerAnimated:YES completion:nil];          // 隐藏视图
    }
}
// 图片保存本地

- (NSString *)saveImg:(UIImage *)curImage WithName:(NSString *)imageName;
{
    NSData *imageData = UIImageJPEGRepresentation(curImage, 1);             // 1为不缩放保存，取值(0~1)
    
    // 获取沙盒路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:imageName];
    
    // 将照片写入文件
    //atomically：这个参数意思是: 如果为YES则保证文件的写入原子性,就是说会先创建一个临时文件,直到文件内容写入成功再导入到目标文件里.如果为NO,则直接写入目标文件里
    if ([imageData writeToFile:path atomically:NO]) {
        return path;
    }  else {
        return nil;
    }
}

@end

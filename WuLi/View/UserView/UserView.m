//
//  UserView.m
//  WuLi
//
//  Created by Mac on 2022/1/21.
//

#import "UserView.h"
@interface UserView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray *commodityHeightArray;
@property (nonatomic) NSMutableArray *circleHeightArray;
@property (nonatomic) NSMutableArray *commodityArray;
@property (nonatomic) NSMutableArray *circleArray;
@property (nonatomic) NSString       *userID;

@end


@implementation UserView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"setContentOffset" object:nil];
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setContentOffset:) name:@"setContentOffset" object:nil];
        _commodityHeightArray   =[[NSMutableArray alloc]init];
        _circleHeightArray      =[[NSMutableArray alloc]init];
        _commodityArray         =[[NSMutableArray alloc]init];
        _circleArray            =[[NSMutableArray alloc]init];
        //[self setUI];
    }
    return self;
}

-(void)layoutWithUserID:(NSString *)ID{
    _userID=ID;
    [GetUserInformationByUserID getUserInformationByUserID:_userID resultBlock:^(UserInformationModel * _Nonnull model) {
        self->_model=model;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self setUI];
        });
    }];
}


-(void)setUI{
    
    //_navigationView=[UIView alloc]initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,32,self.frame.size.width,self.frame.size.height ) style:UITableViewStylePlain];
    [_tableView registerClass:[UserInformationTableViewCell class] forCellReuseIdentifier:@"informationcell"];
    [_tableView registerClass:[UserReleaseTableViewCell class] forCellReuseIdentifier:@"releasecell"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    _tableView.allowsSelection=NO;
    
    [self addSubview:_tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0) return 100;
    else return self.bounds.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        UserInformationTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"informationcell" forIndexPath:indexPath];
        if(_model) [cell layoutWithModel:self.model];
        return cell;
    }else{
        UserReleaseTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"releasecell" forIndexPath:indexPath];
        //cell.backgroundColor=[UIColor blueColor];
        [cell layoutWithUserID:self.userID];
        return cell;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==1){
        UserReleaseHeaderView *header=[[UserReleaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
        return header;
    }
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, CGFLOAT_MIN)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if(section==0) return 0;
    else return 30;
}


-(void)setContentOffset:(NSNotification *)notification{
    CGPoint offset=[[notification.userInfo valueForKey:@"offset"] CGPointValue];
    [self.tableView setContentOffset:offset];
}

@end

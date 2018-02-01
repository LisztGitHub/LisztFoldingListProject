//
//  ViewController.m
//  LisztFoldingListProject
//
//  Created by LisztCoder on 2018/2/1.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "ViewController.h"
#import "LisztFoldingListHeader.h"

#import "LisztFriendTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource,*_statusArray,*_headArray;
}
/** 列表TableView */
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataSource = [NSMutableArray arrayWithArray:@[@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""]]];
    _headArray = [NSMutableArray arrayWithArray:@[@"特别关心",@"你该去吹吹风",@"我要去喝喝酒",@"要远行的友人",@"把孤独带走了",@"oο﹏"]];
    [self.view addSubview:self.tableView];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (((NSNumber *)self.statusArray[section]).integerValue == YES) {
        return [[dataSource objectAtIndex:section] count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LisztFriendTableViewCell";
    LisztFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LisztFriendTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __block LisztFoldingListHeader *lisztHeader = [LisztFoldingListHeader headerWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 40) changeCompleted:^(NSInteger clickIndex) {
        /** 回调实现折叠 */
        BOOL currentIsOpen = ((NSNumber *)self.statusArray[clickIndex]).boolValue;
        
        [self.statusArray replaceObjectAtIndex:clickIndex withObject:[NSNumber numberWithBool:!currentIsOpen]];
        
        NSInteger numberOfRow = [[dataSource objectAtIndex:clickIndex] count];
        NSMutableArray *rowArray = [NSMutableArray array];
        if (numberOfRow) {
            for (NSInteger i = 0; i < numberOfRow; i++) {
                [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:clickIndex]];
            }
        }
        
        if (rowArray.count) {
            lisztHeader.show = currentIsOpen;
            if (currentIsOpen) {
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
            }else{
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
            }
        }
    }];
    [lisztHeader.leftButton setTitle:[NSString stringWithFormat:@"  %@",_headArray[section]] forState:UIControlStateNormal];
    lisztHeader.section = section;
    lisztHeader.show = !((NSNumber *)self.statusArray[section]).boolValue;
    return lisztHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    if (_statusArray.count) {
        if (_statusArray.count > self.tableView.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.tableView.numberOfSections - 1, _statusArray.count - self.tableView.numberOfSections)];
        }else if (_statusArray.count < self.tableView.numberOfSections) {
            for (NSInteger i = self.tableView.numberOfSections - _statusArray.count; i < self.tableView.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:NO]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.tableView.numberOfSections; i++) {
            [_statusArray addObject:[NSNumber numberWithInteger:NO]];
        }
    }
    return _statusArray;
}

#pragma mark - 懒加载子控件
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  InProgressViewController.m
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import "InProgressViewController.h"

#import "Task.h"
#import "UserDefault.h"
#import "InprogressTableViewCell.h"
@interface InProgressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation InProgressViewController{
    NSMutableArray *inprogressArray;
    NSUserDefaults * defaults;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    defaults=[NSUserDefaults standardUserDefaults];
    
    inprogressArray =[[UserDefault readArrayWithCustomObjFromUserDefaults:@"inprogress" withUserDefault:defaults]mutableCopy];
    [_tableview reloadData ];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return inprogressArray.count;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)doneAction:(id)  sender{
   
    Task *task =[inprogressArray objectAtIndex:[sender tag]];
    [inprogressArray removeObjectAtIndex:[sender tag] ];
    [UserDefault writeArrayWithCustomObjToUserDefaults:@"inprogress" withArray:inprogressArray withUserDefault:defaults];
    //for done
    NSMutableArray *arrayDone= [[UserDefault readArrayWithCustomObjFromUserDefaults:@"done" withUserDefault:defaults]mutableCopy];
     [arrayDone addObject:task];
     [UserDefault writeArrayWithCustomObjToUserDefaults:@"done" withArray:arrayDone withUserDefault:defaults];
    [_tableview reloadData];

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InprogressTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"inProgressCell"];
    [cell labelTF].text=[[inprogressArray objectAtIndex:indexPath.row] taskName];
    [cell desTF].text=[[inprogressArray objectAtIndex:indexPath.row] taskDescription];
    
    cell.doneButton.tag=indexPath.row;
    [cell.doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
   
    switch ([[inprogressArray objectAtIndex:indexPath.row] taskPriority]) {
        case 0:
            cell.imageView.image =[UIImage imageNamed:@"0"];
            break;
        case 1:
            cell.imageView.image =[UIImage imageNamed:@"1"];
            break;
        case 2:
            cell.imageView.image =[UIImage imageNamed:@"2"];
            break;
            
        default:
            break;
    }
    
    return  cell;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
@end

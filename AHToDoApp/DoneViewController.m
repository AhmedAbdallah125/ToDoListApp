//
//  DoneViewController.m
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import "DoneViewController.h"
#import "UserDefault.h"
#import "Task.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation DoneViewController
{
    NSMutableArray *doneArray;
    NSUserDefaults * defaults;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    defaults=[NSUserDefaults standardUserDefaults];
    
    doneArray =[[UserDefault readArrayWithCustomObjFromUserDefaults:@"done" withUserDefault:defaults]mutableCopy];
    [_tableview reloadData ];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  doneArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"inProgressCell"];
    [cell textLabel].text=[[doneArray objectAtIndex:indexPath.row] taskName];
    [cell detailTextLabel].text=[[doneArray objectAtIndex:indexPath.row] taskDescription];
    
    
   
    switch ([[doneArray objectAtIndex:indexPath.row] taskPriority]) {
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

@end

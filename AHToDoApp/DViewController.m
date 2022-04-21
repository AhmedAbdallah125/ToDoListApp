//
//  DViewController.m
//  AHToDoApp
//
//  Created by Ahmed on 06/04/2022.
//

#import "DViewController.h"
#import "EditViewController.h"
#import "Task.h"
@interface DViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *desLable;
@property (weak, nonatomic) IBOutlet UILabel *pirotyLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *edit=[[UIBarButtonItem alloc]initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(goToEdit)];
    [self.navigationItem setRightBarButtonItem:edit];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self showData:_current];
    //
}
-(void)showData:(Task*) current{
    [_nameLable setText:current.taskName];
    [_desLable setText:current.taskDescription];
    [_dateLabel setText:
     [NSDateFormatter localizedStringFromDate:
      [NSDate date]dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle]];
    [_pirotyLable setText:[self getPriorty:current.taskPriority]];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)goToEdit{
    EditViewController *eSVC=[self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController" ];
    eSVC.index=_index;
    [self.navigationController pushViewController:eSVC animated:YES];
}
-(NSString *)getPriorty:(int) c{
    switch (c) {
        case 0:
            return @"LOW";
            break;
        case 1:
            return @"MEDIUM";
            break;
        case 2:
            return @"HIGH";
            break;
        default:
            return @"";
            break;
    }
}
@end

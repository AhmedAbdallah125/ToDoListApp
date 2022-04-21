//
//  AddViewController.m
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import "AddViewController.h"
#import "Task.h"
#import "ToDoViewController.h"
#import "UserDefault.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTask;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTask;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmntPriorty;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddViewController
{
    NSUserDefaults *userDefault ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    userDefault =[NSUserDefaults standardUserDefaults];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTaskAction:(id)sender {
    if([self isValid]){
        Task * task=[[Task alloc]init];
        task.taskName= _nameTask.text ;
        task.taskDescription= _descriptionTask.text;
        task.taskPriority=_segmntPriorty.selectedSegmentIndex;
        printf("ss%ld",(long)task.taskPriority);
        task.date=_datePicker.date;
        NSMutableArray *arrayTasks =[[UserDefault readArrayWithCustomObjFromUserDefaults:@"ww" withUserDefault:userDefault] mutableCopy];
        [arrayTasks addObject:task];
        [UserDefault writeArrayWithCustomObjToUserDefaults:@"ww" withArray:arrayTasks withUserDefault:userDefault];
    
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showError];
        
    }

    
    
    
}
-(BOOL) isValid{
    return !([_nameTask.text isEqualToString:@""]&&[_descriptionTask.text isEqualToString:@""]);
}
-(void) showError{
    

        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Invalid Add" message:@"Please Enter All Filds" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
@end

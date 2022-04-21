//
//  EditViewController.m
//  AHToDoApp
//
//  Created by Ahmed on 06/04/2022.
//

#import "EditViewController.h"
#import "UserDefault.h"
#import "Task.h"
@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *desTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPiroty;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation EditViewController{
    NSUserDefaults *defaults;
    NSMutableArray *toDoArray;
    Task * currentTask;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[NSUserDefaults standardUserDefaults];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     toDoArray=[[UserDefault readArrayWithCustomObjFromUserDefaults:@"ww" withUserDefault:defaults]mutableCopy];
 currentTask=[toDoArray objectAtIndex:_index];
    [self showData];
    //
}
-(void) showData{
    _nameTF.text=currentTask.taskName;
    _desTF.text=currentTask.taskDescription;
    _datePicker.date=currentTask.date;
    _segmentPiroty.selectedSegmentIndex=currentTask.taskPriority;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)saveAction:(id)sender {
    if([self isValid]){
        [self ensureEdit];
    }else{
        [self showError];
    }
   
}
-(BOOL) isValid{
    return !([_nameTF.text isEqualToString:@""]&&[_desTF.text isEqualToString:@""]);
}
-(void) showError{
    

        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Invalid Add" message:@"Please Enter All Filds" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
-(void)ensureEdit{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Editing" message:@"Are You sure to edit" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =[UIAlertAction actionWithTitle:@"yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self->currentTask.taskName=self->_nameTF.text;
        self->currentTask.taskDescription=self->_desTF.text;
        self->currentTask.taskPriority=self->_segmentPiroty.selectedSegmentIndex;
        self->currentTask.date=self->_datePicker.date;
        [self->toDoArray replaceObjectAtIndex:self->_index withObject:self->currentTask];
        [UserDefault writeArrayWithCustomObjToUserDefaults:@"ww" withArray:self->toDoArray withUserDefault:self->defaults];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:ok];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

//
//  ViewController.m
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import "ToDoViewController.h"
#import "Task.h"
#import "AddViewController.h"
#import "UserDefault.h"
#import "MyTableViewCell.h"
#import "DViewController.h"
#import "EditViewController.h"
@interface ToDoViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ToDoViewController{
    NSMutableArray *toDoArray;
    NSUserDefaults * defaults;
    BOOL isFiltered;
    NSMutableArray *arraSearchresult, *arraySearchName;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered=NO;
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return isFiltered?arraSearchresult.count:toDoArray.count;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    defaults=[NSUserDefaults standardUserDefaults];
    
    toDoArray =[[UserDefault readArrayWithCustomObjFromUserDefaults:@"ww" withUserDefault:defaults]mutableCopy];
    [_tableview reloadData ];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    printf("begin");
    isFiltered=YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        isFiltered=NO;
    }else{
        isFiltered=YES;
        arraSearchresult=[NSMutableArray new];
        arraySearchName=[NSMutableArray new];
        for(int i=0;i<toDoArray.count;i++){
            NSString * str =[[toDoArray objectAtIndex:i]taskName];
            NSRange  stringRange =[str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(stringRange.location !=NSNotFound){
                [arraSearchresult addObject:[toDoArray objectAtIndex:i]];
            }
        }
    }
    [_tableview reloadData];

}
-(void)doneAction:(id)  sender{
   
    Task *task =[toDoArray objectAtIndex:[sender tag]];
    [toDoArray removeObjectAtIndex:[sender tag] ];
    [UserDefault writeArrayWithCustomObjToUserDefaults:@"ww" withArray:toDoArray withUserDefault:defaults];
    //for done
    NSMutableArray *arrayDone= [[UserDefault readArrayWithCustomObjFromUserDefaults:@"done" withUserDefault:defaults]mutableCopy];
     [arrayDone addObject:task];
     [UserDefault writeArrayWithCustomObjToUserDefaults:@"done" withArray:arrayDone withUserDefault:defaults];
    [_tableview reloadData];

    
}
-(void)inprogressAction:(id)  sender{
   
     Task *task =[toDoArray objectAtIndex:[sender tag]];
     [toDoArray removeObjectAtIndex:[sender tag] ];
     [UserDefault writeArrayWithCustomObjToUserDefaults:@"ww" withArray:toDoArray withUserDefault:defaults];
     //for done
     NSMutableArray *arrayInpogress= [[UserDefault readArrayWithCustomObjFromUserDefaults:@"inprogress" withUserDefault:defaults]mutableCopy];
      [arrayInpogress addObject:task];
      [UserDefault writeArrayWithCustomObjToUserDefaults:@"inprogress" withArray:arrayInpogress withUserDefault:defaults];
    [_tableview reloadData];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell * cell =(MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"toDoCell"];
    if(!isFiltered){
    [cell lableTF].text=[[toDoArray objectAtIndex:indexPath.row] taskName];
    [cell desTF].text=[[toDoArray objectAtIndex:indexPath.row] taskDescription];
    
    cell.done.tag=indexPath.row;
    [cell.done addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.inprogress.tag=indexPath.row;
    [cell.inprogress addTarget:self action:@selector(inprogressAction:) forControlEvents:UIControlEventTouchUpInside];
   
    switch ([[toDoArray objectAtIndex:indexPath.row] taskPriority]) {
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
    }else{
        [cell lableTF].text=[[arraSearchresult objectAtIndex:indexPath.row] taskName];
        [cell desTF].text=[[arraSearchresult objectAtIndex:indexPath.row] taskDescription];
        switch ([[arraSearchresult objectAtIndex:indexPath.row] taskPriority]) {
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
        printf("SS");
        cell.done.hidden=YES;
        cell.inprogress.hidden=YES;
    }
    return  cell;
    
}
- (IBAction)addTask:(id)sender {
    printf("sss");
    AddViewController * addSVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    [self.navigationController pushViewController:addSVC animated:YES];
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
                 [_tableview resignFirstResponder];
             }

             - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
                 isFiltered=NO;
                 [_tableview reloadData];

             }
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!isFiltered){
        [toDoArray removeObjectAtIndex:indexPath.row];
        [UserDefault writeArrayWithCustomObjToUserDefaults:@"ww" withArray:toDoArray withUserDefault:defaults];
        [_tableview reloadData];
    }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!isFiltered){
        DViewController *dSVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DViewController"];
        [dSVC setCurrent:[toDoArray objectAtIndex:indexPath.row]];
        [dSVC setIndex:indexPath.row];
        [self.navigationController pushViewController:dSVC animated:YES];

    }
}
@end

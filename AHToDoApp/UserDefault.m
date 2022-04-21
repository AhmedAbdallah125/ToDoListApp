//
//  UserDefault.m
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import "UserDefault.h"

@implementation UserDefault
+(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray withUserDefault:(NSUserDefaults *)userDefault
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [userDefault setObject:data forKey:keyName];
    [userDefault synchronize];
}
+(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName withUserDefault:(NSUserDefaults *)userDefault
{
    
    NSData *data = [userDefault objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    [userDefault synchronize];
    return myArray;
}
@end

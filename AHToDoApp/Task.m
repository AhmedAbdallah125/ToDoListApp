//
//  Task.m
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import "Task.h"

@implementation Task

- (void)encodeWithCoder:(NSCoder *)coder
{    [coder encodeObject:_taskName forKey:@"name"];
    [coder encodeInt:_taskPriority forKey:@"taskPriority"];
    [coder encodeObject:_taskDescription forKey:@"taskDescription"];
    [coder encodeObject:_date forKey:@"date"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _taskName =[coder decodeObjectForKey:@"name"];
       _taskPriority =[coder decodeIntForKey:@"taskPriority"] ;
        _taskDescription =[coder decodeObjectForKey:@"taskDescription"];
        _date=[coder decodeObjectForKey:@"date"];
        
    }
    return self;
}
@end

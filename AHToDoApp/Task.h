//
//  Task.h
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property NSString *taskName,* taskDescription;
@property int taskPriority;
@property NSDate *date;



    @end

NS_ASSUME_NONNULL_END

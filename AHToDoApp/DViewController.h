//
//  DViewController.h
//  AHToDoApp
//
//  Created by Ahmed on 06/04/2022.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface DViewController : UIViewController
@property Task * current;
@property int index;
@end

NS_ASSUME_NONNULL_END

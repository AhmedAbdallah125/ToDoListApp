//
//  InprogressTableViewCell.h
//  AHToDoApp
//
//  Created by Ahmed on 06/04/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InprogressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *labelTF;

@property (weak, nonatomic) IBOutlet UILabel *desTF;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@end

NS_ASSUME_NONNULL_END

//
//  MyTableViewCell.h
//  AHToDoApp
//
//  Created by Ahmed on 05/04/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lableTF;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *desTF;
@property (weak, nonatomic) IBOutlet UIButton *inprogress;
@property (weak, nonatomic) IBOutlet UIButton *done;
@end

NS_ASSUME_NONNULL_END

//
//  TextImageTableViewCell.h
//  VictorTask1
//
//  Created by Mironchik on 27.10.24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextImageTableViewCell : UITableViewCell
    @property (nonatomic, weak) IBOutlet UILabel *leftTextLabel;
    @property (nonatomic, weak) IBOutlet UIImageView *rightImageView;
@end

NS_ASSUME_NONNULL_END

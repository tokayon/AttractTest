//
//  CustomCell.h
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *customTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *customDetailTextLabel;

@end

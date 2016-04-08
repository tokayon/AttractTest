//
//  DetailViewController.h
//  AttractTest
//
//  Created by SergeSinkevych on 08.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (assign, nonatomic) NSUInteger pageIndex;
@property (strong, nonatomic) NSData *heroImageData;
@property (strong, nonatomic) NSString *heroName;
@property (strong, nonatomic) NSString *heroDescription;
@property (strong, nonatomic) NSString *heroDate;
@property (strong, nonatomic) NSString *heroId;

@end

//
//  DetailViewController.m
//  AttractTest
//
//  Created by SergeSinkevych on 08.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageWithData:self.heroImageData];
    self.nameLabel.text = self.heroName;
    self.descriptionLabel.text = self.heroDescription;
    self.dateLabel.text = self.heroDate;
    self.idLabel.text = self.heroId;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

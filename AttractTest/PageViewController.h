//
//  PageViewController.h
//  AttractTest
//
//  Created by SergeSinkevych on 08.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagedObject.h"

@interface PageViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

//@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pages;
@property (strong, nonatomic) NSArray *pagesData;
@property (assign, nonatomic) NSInteger inputIndex;

@end
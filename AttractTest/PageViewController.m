//
//  PageViewController.m
//  AttractTest
//
//  Created by SergeSinkevych on 08.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "PageViewController.h"
#import "DetailViewController.h"

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    DetailViewController *startingViewController = [self viewControllerAtIndex:self.inputIndex];
    
    //self.pageControl.currentPage = self.inputIndex;
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    self.pageViewController.view.frame = self.view.bounds;
    [self.pageViewController didMoveToParentViewController:self];
    
}

//MARK: UIPageViewControllerDataSource


- (DetailViewController *)viewControllerAtIndex:(NSUInteger)index {
    if ((self.pages.count == 0) || (index >= self.pages.count)) {
        return nil;
    }
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    ManagedObject *object = self.pages[index];
    detailVC.heroName = [object valueForKey:@"heroName"];
    detailVC.heroImageData = [object valueForKey:@"heroImageData"];
    detailVC.heroDescription = [object valueForKey:@"heroDescription"];
    detailVC.heroDate = [object valueForKey:@"heroDate"];
    detailVC.heroId  = [object valueForKey:@"heroId"];
    detailVC.pageIndex = index;
    return detailVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((DetailViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((DetailViewController*) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return self.inputIndex;
}


@end

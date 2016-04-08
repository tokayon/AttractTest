//
//  ContainerViewController.m
//  AttractTest
//
//  Created by SergeSinkevych on 05.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "ContainerViewController.h"
#import "MainViewController.h"

@interface ContainerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainContainerView;
@property (weak, nonatomic) IBOutlet UIView *fakeContainerView;
@property (strong, nonatomic) NSArray *menuArray;


@end

@implementation ContainerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.navigationController.navigationBar.hidden = true;
    }
    
    self.menuArray = @[@"Main", @"List of items", @"Settings"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.view addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:swipeRight];
        self.navigationController.navigationBar.translucent = YES;
        [(UIView*)[self.navigationController.navigationBar.subviews objectAtIndex:0] setAlpha:0.8f];

    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.navigationController.navigationBar.hidden = true;
    }
}

//MARK: Actions

- (IBAction)showMenu:(id)sender {
    
    if(self.mainContainerView.frame.origin.x == 0) //only show the menu if it is not already shown
        [self showMenu];
    else
        [self hideMenu];
    
}

//MARK: MenuAnimations

-(void)showMenu{
    MainViewController *mainVC = [self.childViewControllers lastObject];
    [mainVC.searchBar resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(self.tableView.frame.size.width*0.8, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
        
        [self.mainContainerView setFrame:CGRectMake(self.tableView.frame.size.width*0.8, self.mainContainerView.frame.origin.y, self.mainContainerView.frame.size.width, self.mainContainerView.frame.size.height)];
    }];
}

-(void)hideMenu{
    
    [UIView animateWithDuration:.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
        
        [self.mainContainerView setFrame:CGRectMake(0, self.mainContainerView.frame.origin.y, self.mainContainerView.frame.size.width, self.mainContainerView.frame.size.height)];
    }];
}

//MARK: GestureActions

-(void)handleSwipeLeft:(UISwipeGestureRecognizer*)recognizer{
    
    if(self.mainContainerView.frame.origin.x != 0)
        [self hideMenu];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer*)recognizer{
    if(self.mainContainerView.frame.origin.x == 0)
        [self showMenu];
}

//MARK: UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.text = self.menuArray[indexPath.row];
    CALayer *separator = [CALayer layer];
    separator.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.25].CGColor;
    separator.frame = CGRectMake(0, 43, cell.frame.size.width, .5);
    [cell.layer addSublayer:separator];
    return cell;
    
}

//MARK: UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainViewController *mainVC = [self.childViewControllers lastObject];
    switch (indexPath.row) {
        case 0:
            mainVC.view.backgroundColor = [UIColor lightGrayColor];
            mainVC.searchBar.hidden = false;
            mainVC.tableView.hidden = false;
            break;
        case 1:
            mainVC.view.backgroundColor = [UIColor lightGrayColor];
            mainVC.searchBar.hidden = true;
            mainVC.tableView.hidden = true;
            break;
        case 2:
            mainVC.view.backgroundColor = [UIColor brownColor];
            mainVC.searchBar.hidden = true;
            mainVC.tableView.hidden = true;
        default:
            break;
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self hideMenu];
    }
}


@end

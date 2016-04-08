//
//  MainViewController.m
//  AttractTest
//
//  Created by SergeSinkevych on 05.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "MainViewController.h"
#import "Person.h"
#import "DownloadManager.h"
#import "CustomCell.h"
#import "Manager.h"
#import "PageViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSMutableArray *heros;
    NSArray *fetchedObjects;
    NSUInteger selectedIndex;
}

@property (strong, nonatomic) NSArray *jsonArray;
@property (strong, nonatomic) NSArray *personsArray;
@property (strong, nonatomic) Manager *manager;
@property (strong, nonatomic) DownloadManager *downloadManager;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSString *urlString = @"http://others.php-cd.attractgroup.com/test.json";
    self.downloadManager = [DownloadManager sharedInstance];
    self.manager = [Manager sharedInstance];
    heros = [NSMutableArray new];
    UINib *nib = [UINib nibWithNibName:@"CustomCellNib" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"customCellId"];
    
    [self fetchObjectsFromDataBase:nil];
    if (!(fetchedObjects.count > 0)) {
        [self getArray:urlString];
    }
}

- (void) fetchObjectsFromDataBase:(NSPredicate *)predicate {
    [heros removeAllObjects];
    
    fetchedObjects = [self.manager getHerosWithPredicate:predicate];
    for (NSManagedObject *currentObject in fetchedObjects) {
        [heros addObject:currentObject];
    }

    [self.tableView reloadData];
}

- (void)getArray:(NSString *)url {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.downloadManager getJsonArrayFromURL:url withCompletion:^(NSArray *jsonArray, NSError *jsonError) {
        if (!jsonError) {
            self.personsArray = [self getPersons:jsonArray];
            [self fetchObjectsFromDataBase:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self.tableView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self showError:jsonError];
            });
        }
    }];
}

- (NSArray *)getPersons:(NSArray *)array {
    NSMutableArray *personsMutable = [NSMutableArray new];
    for (NSDictionary *dict in array) {
        Person *person = [[Person alloc] initWithDict:dict];
        [personsMutable addObject:person];
        
        ManagedObject *managedObject = [self.manager createHero];
        managedObject.heroName = person.name;
        managedObject.heroImageUrl = person.imageURL;
        managedObject.heroId = person.itemId;
        managedObject.heroDescription = person.personDescription;
        managedObject.heroDate = person.date;
        
        [self.manager saveContext];
    }
    return [personsMutable copy];
}

- (void)showError:(NSError *)error {
    NSString *message = [NSString stringWithFormat:@"%@", error.localizedDescription];
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Ups!"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

//MARK: UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return heros.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCellId"];
    NSManagedObject *hero = [heros objectAtIndex:indexPath.row];
    cell.customTextLabel.text = [hero valueForKey:@"heroName"];
    cell.customDetailTextLabel.text = [hero valueForKey:@"heroDate"];
    cell.posterView.image = [UIImage imageNamed:@"placeholder.png"];
    CALayer *separator = [CALayer layer];
    separator.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.25].CGColor;
    separator.frame = CGRectMake(0, 69, cell.frame.size.width, .5);
    [cell.layer addSublayer:separator];
    
    
    NSURL *imageURL = [NSURL URLWithString:[hero valueForKey:@"heroImageUrl"]];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            [hero setValue:data forKey:@"heroImageData"];
            [self.manager saveContext];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CustomCell *reuseCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (reuseCell) {
                        reuseCell.posterView.image = image;
                    }
                });
            }
        }
    }];
    [task resume];
    return cell;
    
}

//MARK: UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"pageVCSegue" sender:self];
}

//MARK: UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterContentForSearchText:searchText];
}

- (void)filterContentForSearchText:(NSString*)searchText {
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"heroName contains[cd] %@",
                                    searchText];
    (searchText.length == 0) ? [self fetchObjectsFromDataBase:nil] : [self fetchObjectsFromDataBase:resultPredicate];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PageViewController *pageVC = segue.destinationViewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.navigationController.navigationBar.hidden = false;
    }
    pageVC.inputIndex = selectedIndex;
    pageVC.pages = fetchedObjects;
}












@end


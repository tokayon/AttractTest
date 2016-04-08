//
//  Manager.m
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "Manager.h"

@implementation Manager {
    NSManagedObjectContext *_objectContext;
    NSManagedObjectModel *_objectModel;
    NSPersistentStoreCoordinator *_objectCoordinator;
}

+ (Manager *) sharedInstance {
    static Manager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [Manager new];
    });
    return sharedInstance;
}

// To take from entity
- (NSManagedObjectModel *)objectModel {
    
    if (_objectModel != nil) {
        return _objectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AttractTest"
                                              withExtension:@"momd"];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _objectModel;
}

- (NSPersistentStoreCoordinator *)objectCoordinator {
    
    if (_objectCoordinator != nil) {
        return _objectCoordinator;
    }
    
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"AttractTest.sqlite"];
    
    NSError *error = nil;
    
    _objectCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self objectModel]];
    if (![_objectCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        //delete file and create new
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        if ([_objectCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            return _objectCoordinator;
        }
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
    return _objectCoordinator;
    
}

- (NSManagedObjectContext *)objectContext {
    
    if (_objectContext != nil) {
        return _objectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self objectCoordinator];
    
    if (coordinator != nil) {
        _objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:(NSPrivateQueueConcurrencyType)];
        [_objectContext setPersistentStoreCoordinator:coordinator];
    }
    return _objectContext;
}

- (NSArray *)getHerosWithPredicate:(NSPredicate *)predicate {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hero"];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setReturnsObjectsAsFaults:NO];

    NSError *error = nil;
    NSArray *fetchObjects = [[self objectContext] executeFetchRequest:fetchRequest error:&error];
    if ([fetchObjects count] == 0) {
        return nil;
    }
    
    return fetchObjects;
    
}

- (ManagedObject *)createHero {
    ManagedObject *hero = [NSEntityDescription insertNewObjectForEntityForName:@"Hero" inManagedObjectContext:[self objectContext]];
    return hero;
}

- (void)removeHero:(ManagedObject *)managedObject {
    [self.objectContext deleteObject:managedObject];
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *context = [self objectContext];
    if (context != nil) {
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

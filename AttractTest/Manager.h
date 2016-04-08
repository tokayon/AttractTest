//
//  Manager.h
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedObject.h"

@interface Manager : NSObject

+ (Manager *) sharedInstance;
- (NSArray *)getHerosWithPredicate:(NSPredicate *)predicate;
- (ManagedObject *)createHero;
- (void)removeHero:(ManagedObject *)managedObject;
- (void)saveContext;

@end

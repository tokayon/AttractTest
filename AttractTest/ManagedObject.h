//
//  ManagedObject.h
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ManagedObject : NSManagedObject

@property (strong, nonatomic) NSString *heroName;
@property (strong, nonatomic) NSString *heroImageUrl;
@property (assign, nonatomic) NSString *heroId;
@property (strong, nonatomic) NSString *heroDescription;
@property (strong, nonatomic) NSString *heroDate;
@property (strong, nonatomic) NSData *heroImageData;




@end

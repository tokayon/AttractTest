//
//  Person.h
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *personDescription;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *date;
@property (assign, nonatomic) NSString *itemId;
@property (strong, nonatomic) UIImage *personImage;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

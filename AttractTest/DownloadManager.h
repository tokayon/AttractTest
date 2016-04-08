//
//  DownloadManager.h
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadManager : NSObject

+ (DownloadManager *)sharedInstance;

- (void)getJsonArrayFromURL:(NSString *)url withCompletion:(void(^)(NSArray *jsonArray, NSError *jsonError))completion;

@end

//
//  DownloadManager.m
//  AttractTest
//
//  Created by SergeSinkevych on 07.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "DownloadManager.h"
#import "Person.h"

@implementation DownloadManager

+ (DownloadManager *)sharedInstance {
    
    static dispatch_once_t once;
    static DownloadManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [DownloadManager new];
    });
    return sharedInstance;
    
}

- (void)getJsonArrayFromURL:(NSString *)url withCompletion:(void(^)(NSArray *jsonArray, NSError *jsonError))completion {
    [self getDataFromURL:url withCompletion:^(NSData *managerData, NSError *managerError) {
        if (!managerError) {
            [self serialization:managerData withCompletion:^(NSArray *serializationArray, NSError *serializationError) {
                completion(serializationArray, serializationError);
            }];
        } else {
            completion(nil, managerError);
        }
    }];
}

- (void)getDataFromURL:(NSString *)url withCompletion:(void(^)(NSData *managerData, NSError *managerError))completion {
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask* sessionDataTask = [session dataTaskWithRequest:request
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                             {
                                                 completion(data, error);
                                             }];
    [sessionDataTask resume];

}

- (void)serialization:(NSData *)data withCompletion:(void(^)(NSArray *serializationArray, NSError *serializationError))completion {
    NSError *jsonError;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    completion(json, jsonError);
}





@end

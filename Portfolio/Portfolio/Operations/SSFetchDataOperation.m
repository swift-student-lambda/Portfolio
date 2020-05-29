//
//  SSFetchDataOperation.m
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSFetchDataOperation.h"

@interface SSFetchDataOperation ()

@property NSURLSessionDataTask *fetchDataTask;

@end

@implementation SSFetchDataOperation

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (!self) { return nil; }
    
    _url = url;
    
    return self;
}

- (void)main {
    if (self.isCancelled) { return; }
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:self.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@"Error fetching data: %@", error);
            return;
        }

        if (!data) {
            NSLog(@"Error fetching data: no data");
            return;
        }

        self.data = data;
        [self finish];
    }];
    
    [task resume];
}

- (void)cancel {
    [self.fetchDataTask cancel];
    [super cancel];
}

@end

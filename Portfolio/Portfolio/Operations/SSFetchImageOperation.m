//
//  SSFetchImageOperation.m
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSFetchImageOperation.h"

@interface SSFetchImageOperation ()

@property NSURLSessionDataTask *fetchImageTask;

@end

@implementation SSFetchImageOperation

- (instancetype)initWithImageURL:(NSURL *)imageURL {
    self = [super init];
    if (!self) { return nil; }
    
    _imageURL = imageURL;
    
    return self;
}

- (void)main {
    if (self.isCancelled) { return; }
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:self.imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@"Error fetching image: %@", error);
            return;
        }

        if (!data) {
            NSLog(@"Error fetching image: no data");
            return;
        }

        self.imageData = data;
        [self finish];
    }];
    
    [task resume];
}

- (void)cancel {
    [self.fetchImageTask cancel];
    [super cancel];
}

@end

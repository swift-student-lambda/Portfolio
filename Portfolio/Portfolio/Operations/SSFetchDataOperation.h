//
//  SSFetchDataOperation.h
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSConcurrentOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSFetchDataOperation : SSConcurrentOperation

@property NSURL *url;
@property NSData *data;

- (instancetype)initWithURL:(NSURL *)imageURL;

@end

NS_ASSUME_NONNULL_END

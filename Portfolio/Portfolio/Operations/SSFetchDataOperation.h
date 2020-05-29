//
//  SSFetchDataOperation.h
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSConcurrentOperation.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FetchDataOperation)
@interface SSFetchDataOperation : SSConcurrentOperation

@property (nonatomic) NSURL *url;
@property (nonatomic, nullable) NSData *data;

- (instancetype)initWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END

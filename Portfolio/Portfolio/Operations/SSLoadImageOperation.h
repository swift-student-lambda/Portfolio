//
//  SSLoadImageOperation.h
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSConcurrentOperation.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(LoadImageOperation)
@interface SSLoadImageOperation : SSConcurrentOperation

@property (nonatomic) NSURL *url;
@property (nonatomic, weak) UIImageView *imageView;


- (instancetype)initWithURL:(NSURL *)url
                  imageView:(UIImageView *)imageView;

@end

NS_ASSUME_NONNULL_END

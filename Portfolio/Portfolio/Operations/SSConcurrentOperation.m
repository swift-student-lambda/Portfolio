//
//  SSConcurrentOperation.m
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSConcurrentOperation.h"

@interface SSConcurrentOperation ()

@property (nonatomic) SSConcurrentOperationState state;

- (NSString *)keyForState:(SSConcurrentOperationState)state;

@end

@implementation SSConcurrentOperation

- (BOOL)isReady {
    return super.isReady && self.state == SSSConcurrentOperationStateReady;
}

- (BOOL)isExecuting {
    return self.state == SSSConcurrentOperationStateExecuting;
}

- (BOOL)isFinished {
    return self.state == SSSConcurrentOperationStateFinished;
}

- (BOOL)isAsynchronous {
    return true;
}

@synthesize state = _state;

- (SSConcurrentOperationState)state {
    // lazy var
    if (!_state) {
        _state = SSSConcurrentOperationStateReady;
    }
    
    return _state;
}

- (void)setState:(SSConcurrentOperationState)state {
    // Make sure we are changing the state
    if (state == _state) { return; }
    
    // Get the corresponding keys
    NSString *oldKey = [self keyForState:_state];
    NSString *newKey = [self keyForState:state];
 
    // willSet
    [self willChangeValueForKey:oldKey];
    [self willChangeValueForKey:newKey];
    
    // set
    _state = state;
    
    // didSet
    [self didChangeValueForKey:oldKey];
    [self didChangeValueForKey:newKey];
}

- (NSString *)keyForState:(SSConcurrentOperationState)state {
    switch (state) {
        case SSSConcurrentOperationStateReady:
            return @"ready";
            break;
        case SSSConcurrentOperationStateExecuting:
            return @"executing";
            break;
        case SSSConcurrentOperationStateFinished:
            return @"finished";
            break;
        default:
            break;
    }
    return nil;
}

- (void)start {
    if (self.isCancelled) {
        [self finish];
        return;
    }
    
    if (!self.isExecuting) {
        self.state = SSSConcurrentOperationStateExecuting;
    }
    
    [self main];
}

- (void)finish {
    if (self.isExecuting) {
        self.state = SSSConcurrentOperationStateFinished;
    }
}

- (void)cancel {
    [super cancel];
    [self finish];
}


@end

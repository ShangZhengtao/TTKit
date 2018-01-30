//
//  TTDynamicKit.m
//  Dynamic
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import "TTDynamicSession.h"
#import <CoreMotion/CoreMotion.h>

static const NSTimeInterval kTTUpdateInterval = 0.8;//监听频率
static const double         kTTSensitivity = 0.01; //灵敏度
static const double         kTTStrength = 2; //加速度倍数加成

@interface TTDynamicSession()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, strong) UIGravityBehavior *gravity;

@end

@implementation TTDynamicSession

- (void)addGravityBehaviorItems:(NSArray<__kindof UIView *> *)items toContainerView:(UIView *)view {
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:view];
    self.gravity = [[UIGravityBehavior alloc]initWithItems:items];
    self.gravity.magnitude = 1; //初始加速度
    //碰撞检测
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:items];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    [self.animator addBehavior:self.gravity];
    [self startUpdateAccelerometer];
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}
//开启加速计
- (void)startUpdateAccelerometer {
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = kTTUpdateInterval;
        __weak typeof(self) weakSelf = self;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             double x = accelerometerData.acceleration.x;
             double y = accelerometerData.acceleration.y;
             if (ABS(x) < kTTSensitivity && ABS(y) < kTTSensitivity) {
                 return;
             }
             [weakSelf.gravity setGravityDirection:CGVectorMake(kTTStrength * x, -kTTStrength * y)];
         }];
    }
}

- (void)stopUpdate {
    if (self.motionManager.accelerometerActive) {
        [self.motionManager stopAccelerometerUpdates];
    }
}

- (void)dealloc {
    [self stopUpdate];
    _motionManager = nil;
}

@end

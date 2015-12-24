//
//  ViewController.m
//  rollingBall
//
//  Created by student on 22/12/2015.
//  Copyright © 2015 dungdang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView* ball;
    CGFloat ballRadius;
    CGFloat angle;
    NSTimer *timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBall];
    angle = 0.0;
    
        
        
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                             target:self
                                           selector:@selector(rollingBall)
                                           userInfo:nil
                                            repeats:true];
   // [self rollingBall2];

}

-(void) addBall {
    CGSize mainViewSize = self.view.bounds.size;
    
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ball.png"]];
    ballRadius = 32.0;
    ball.center = CGPointMake(ballRadius, mainViewSize.height * 0.5);
//    CGFloat deltaAngle = 0.1;
//    angle += deltaAngle;
//    ball.transform= CGAffineTransformMakeRotation(angle);
    [self.view addSubview:ball];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

- (void)rollingBall{
    CGFloat deltaAngle = 0.2;
    angle += deltaAngle;
    int a= 1;
    
         ball.center = CGPointMake(ball.center.x + ballRadius*deltaAngle, ball.center.y);
    if ((ball.center.x >= self.view.bounds.size.width-ballRadius)) {
        a=-1;
        ballRadius= -ballRadius;
        NSLog(@"%f,%d",ballRadius,a);
    } else if(ball.center.x + ballRadius <= 0 ){
        a=1;
        ballRadius= 32.0;
        NSLog(@"%f,%d",ballRadius,a);
    }
    ball.transform= CGAffineTransformMakeRotation(a*angle);

}


- (void)rollingBall2{
//    CGFloat deltaAngle = 0.1;
//    angle += deltaAngle;
    ball.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:5
                     animations:^{
                         ball.center = CGPointMake(self.view.bounds.size.width-ballRadius,self.view.bounds.size.height*0.5 );
                     }
                     completion:^(BOOL finished) {
                         ball.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(-1, 1), ball.transform= CGAffineTransformMakeRotation(angle));
                         [UIView animateWithDuration:5
                                          animations:^{
                                              ball.center = CGPointMake(ballRadius, self.view.bounds.size.height * 0.5);
                                          }
                                          completion:^(BOOL finished) {
                                              [self rollingBall2];
                                          }];
                     }];

}
@end

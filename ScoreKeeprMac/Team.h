//
//  Team.h
//  ScoreKeeprMac
//
//  Created by Nicholas McGuire on 2012-12-03.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (strong, nonatomic) NSString *colour;
@property (strong, nonatomic) NSNumber *greenBallOver;
@property (strong, nonatomic) NSNumber *greenBall;
@property (strong, nonatomic) NSNumber *football;
@property (strong, nonatomic) NSNumber *basketBall;
@property (nonatomic, getter = isAutonomousWinner) BOOL autonomousWinner;

@end

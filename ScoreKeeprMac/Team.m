//
//  Team.m
//  ScoreKeeprMac
//
//  Created by Nicholas McGuire on 2012-12-03.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "Team.h"

@implementation Team

- (BOOL)isAutonomousWinner
{
	if (_autonomousWinner)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

@end

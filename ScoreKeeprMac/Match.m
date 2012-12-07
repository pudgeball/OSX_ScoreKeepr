//
//  Match.m
//  ScoreKeeprMac
//
//  Created by Nicholas McGuire on 2012-12-03.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "Match.h"
#import "Team.h"

@interface Match()
- (NSNumber *)calculateTeamScore:(Team *)team;
@end


@implementation Match

- (id)initWithMatchNumber:(NSString *)matchNumber
{
	self = [super init];
	
	if (self)
	{
		_matchNumber = matchNumber;
		_redTeam = [Team new];
		_blueTeam = [Team new];
	}
	
	return self;
}

- (NSNumber *)calculateTeamScore:(Team *)team
{
	int score = ([team isAutonomousWinner] * 15) + ([[team greenBallOver] intValue] * 5) + ([[team greenBall] intValue] * 1) + ([[team football] intValue] * 10) + ([[team basketBall] intValue] * 10);
	
	return [NSNumber numberWithInt:score];
}

- (NSDictionary *)calculateMatchScore
{
	NSDictionary *results = @{ @"RedScore" : [self calculateTeamScore:_redTeam], @"BlueScore" : [self calculateTeamScore:_blueTeam] };
	
	return results;
}

@end

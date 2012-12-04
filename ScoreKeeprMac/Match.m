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
	//int score = ( [team isAutonomousWinner] * AUTONOMOUS ) + (team.greenBallOver * GREEN_BALL_OVER );
	//int score = [[team.greenBallOver * GREEN_BALL_OVER] int] + team.greenBall * GREEN_BALL + team.football * FOOTBALL;
	
	int score = 0;
	return [NSNumber numberWithInt:score];
}

- (NSDictionary *)calculateMatchScore
{
	NSDictionary *results = @{ @"RedScore" : [self calculateTeamScore:_redTeam], @"BlueScore" : [self calculateTeamScore:_blueTeam] };
	
	return results;
}

@end

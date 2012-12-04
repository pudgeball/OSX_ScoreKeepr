//
//  Match.h
//  ScoreKeeprMac
//
//  Created by Nicholas McGuire on 2012-12-03.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Team;

@interface Match : NSObject

@property (strong, nonatomic) NSString *matchNumber;
@property (strong, nonatomic) Team *redTeam;
@property (strong, nonatomic) Team *blueTeam;

- (id)initWithMatchNumber:(NSString *)matchNumber;
- (NSDictionary *)calculateMatchScore;

@end

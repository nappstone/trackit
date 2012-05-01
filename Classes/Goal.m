//
//  Goal.m
//  TrackIT
//
//  Created by jonathan saville on 22/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Goal.h"

@implementation Goal
@synthesize goalID, matchID, homeTeamGoal, goalType, goalName, points, minute;

-(id)initWithGoalID:(int)gid matchID:(int)mid homeTeamGoal:(BOOL)h goalType:(int)g goalName:(NSString *)n points:(int)p minute:(int)m
{
	self.goalID = gid;
	self.matchID = mid;
	self.homeTeamGoal = h;
	self.goalType = g;
	self.goalName = n;
	self.points=p;
	self.minute = m;
	return self;
}
@end

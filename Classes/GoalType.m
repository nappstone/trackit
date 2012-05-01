//
//  GoalType.m
//  TrackIT
//
//  Created by jonathan saville on 23/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoalType.h"

@implementation GoalType
@synthesize goalTypeID, name, description, points;

-(id)initWithGoalTypeID:(int)gtid name:(NSString *)n description:(NSString *)d points:(int)p
{
	self.goalTypeID = gtid;
	self.name = n;
	self.description = d;
	self.points = p;
	
	return self;
}
@end

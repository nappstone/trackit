//
//  Goal.h
//  TrackIT
//
//  Created by jonathan saville on 22/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Goal : NSObject
{
	int  goalID;
	int  matchID;
	BOOL homeTeamGoal;
	int  goalType;
	NSString *goalName;
	int	 points;
	int  minute;
}

@property (nonatomic) int goalID;
@property (nonatomic) int matchID;
@property (nonatomic) BOOL homeTeamGoal;
@property (nonatomic) int goalType;
@property (nonatomic, retain) NSString *goalName;
@property (nonatomic) int points;
@property (nonatomic) int minute;

-(id)initWithGoalID:(int)gid matchID:(int)mid homeTeamGoal:(BOOL)h goalType:(int)g goalName:(NSString *)n points:(int)p minute:(int)m;

@end

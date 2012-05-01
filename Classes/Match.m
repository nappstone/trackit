#import "Match.h"
#import "Goal.h"

@implementation Match

@synthesize matchID, name, description, homeTeamID, awayTeamID, date, kickoff, secondHalf, homeTeamName, awayTeamName, homeTeamGoals, awayTeamGoals;

-(id)initWithMatchID:(int)mid name:(NSString *)n description:(NSString *)ds homeTeamID:(int)htid awayTeamID:(int)atid date:(NSDate *)d kickoff:(NSDate *)k secondHalf:(NSDate *)sh homeTeamName:(NSString *)htn awayTeamName:(NSString *)atn homeTeamGoals:(NSMutableArray *)htg awayTeamGoals:(NSMutableArray *)atg
{
	self.matchID = mid;
	self.name = n;
	self.description = ds;
	self.homeTeamID = htid;
	self.awayTeamID = atid;
	self.date = d;
	self.kickoff = k;
	self.secondHalf = sh;
	self.homeTeamName = htn;
	self.awayTeamName = atn;
	self.homeTeamGoals = htg;
	self.awayTeamGoals = atg;
	
	return self;
}
-(int)getTeamScore:(BOOL)home
{
	int i=0;
	NSMutableArray *goals = (home ? self.homeTeamGoals : self.awayTeamGoals);
	for(Goal* goal in goals) i += goal.points;
	return i;
}

-(NSString *)getTeamScoreStr:(BOOL)home
{
	return [[NSString alloc] initWithFormat:@"%i", [self getTeamScore:home]];
}

-(int)getTeamGoalCount:(BOOL)home goalType:(int)gt
{
	int i=0;
	NSMutableArray *goals = (home ? self.homeTeamGoals : self.awayTeamGoals);
	for(Goal* goal in goals) if(goal.goalType == gt) i++;
	return i;
}

/*
 -(NSString *)getHomeTeamGoalCountStr:(BOOL)home (int)i
{
	return [[NSString alloc] initWithFormat:@"%i", [self getHomeTeamGoalCount:i]];	
}

-(NSString *)getAwayTeamGoalCountStr:(int)i
{
	return [[NSString alloc] initWithFormat:@"%i", [self getAwayTeamGoalCount:i]];	
}
*/

@end

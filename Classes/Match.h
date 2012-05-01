#import <UIKit/UIKit.h>

@interface Match : NSObject
{
	int matchID;
	NSString *name;
	NSString *description;
	int homeTeamID;
	int awayTeamID;
	NSDate *date;
	NSDate *kickoff;
	NSDate *secondHalf;
	
	NSString *homeTeamName;
	NSString *awayTeamName;
	NSMutableArray *homeTeamGoals;
	NSMutableArray *awayTeamGoals;
}

@property (nonatomic) int matchID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) int homeTeamID;
@property (nonatomic) int awayTeamID;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *kickoff;
@property (nonatomic, retain) NSDate *secondHalf;
@property (nonatomic, retain) NSString *homeTeamName;
@property (nonatomic, retain) NSString *awayTeamName;
@property (nonatomic, retain) NSMutableArray *homeTeamGoals;
@property (nonatomic, retain) NSMutableArray *awayTeamGoals;

-(id)initWithMatchID:(int)mID name:(NSString *)n description:(NSString *)ds homeTeamID:(int)htid awayTeamID:(int)atid date:(NSDate *)d kickoff:(NSDate *)k secondHalf:(NSDate *)sh homeTeamName:(NSString *)htn awayTeamName:(NSString *)atn homeTeamGoals:(NSMutableArray *)htg awayTeamGoals:(NSMutableArray *)atg;

-(int)getTeamScore:(BOOL)home;
-(NSString *)getTeamScoreStr:(BOOL)home;
-(int)getTeamGoalCount:(BOOL)home goalType:(int)gt;
/*
-(NSString *)getHomeTeamGoalCountStr:(int)i;
-(NSString *)getAwayTeamGoalCountStr:(int)i;
*/
@end

#import "Team.h"

@implementation Team
@synthesize teamID, name, comments, favourite;

-(id)initWithTeamID:(int)tid name:(NSString *)n comments:(NSString *)c favourite:(BOOL)f
{
	self.teamID = tid;
	self.name = n;
	self.comments = c;
	self.favourite = f;
	
	return self;
}
@end

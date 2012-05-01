#import <UIKit/UIKit.h>

@interface Team : NSObject
{
	int teamID;
	NSString *name;
	NSString *comments;
	BOOL favourite;
}

@property (nonatomic) int teamID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comments;
@property (nonatomic) BOOL favourite;

-(id)initWithTeamID:(int)tid name:(NSString *)n comments:(NSString *)c favourite:(BOOL)f;

@end

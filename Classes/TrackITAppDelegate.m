#import "TrackITAppDelegate.h"
#import "Constants.h"
#import "RootViewController.h"
#import "Team.h"
#import "Match.h"
#import "Goal.h"
#import "GoalType.h"

@implementation TrackITAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize teams;
@synthesize goalTypes;
@synthesize matchesByTeam;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	// Setup some globals
	SqliteDateFormatter = [[NSDateFormatter alloc] init];
	SqliteTimeFormatter = [[NSDateFormatter alloc] init];
	[SqliteDateFormatter setDateFormat:SQLITE_DATE_FORMAT];
	[SqliteTimeFormatter setDateFormat:SQLITE_TIME_FORMAT];

	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:DATABASE_NAME];
	
	// Execute the "checkAndCreateDatabase" function
	[self checkAndCreateDatabase];
	
	// Query the database and construct data arrays
	[self loadFromDatabase];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}

-(void) checkAndCreateDatabase
{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	[fileManager release];
}

-(void) loadFromDatabase
{
	// Setup the database object
	sqlite3 *database;
	
	// Init the global data arrays
	teams			= [[NSMutableArray alloc] init];
	goalTypes		= [[NSMutableArray alloc] init];
	matchesByTeam	= [[NSMutableDictionary alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
	{
		NSMutableArray *matches	= [[NSMutableArray alloc] init];

		// Setup the SQL Statement and compile it for faster access		
		sqlite3_stmt *compiledStatement;
		
		// Load the Teams...
		char *sqlStatement = "select id,name,comments,favourite FROM team ORDER BY name";		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			// Loop through the results and add them to the teams array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
			{
				int aTeamID			= [self getIntCol:compiledStatement index:0];
				NSString *aName		= [self getTextCol:compiledStatement index:1];
				NSString *aComments = [self getTextCol:compiledStatement index:2];
				BOOL aFavourite		= [self getBoolCol:compiledStatement index:3];
				
				Team *team = [[Team alloc] initWithTeamID:aTeamID name:aName comments:aComments favourite:aFavourite];
				NSLog(@"Loaded team %i (name: %@, comments: %@)",aTeamID,aName,aComments);
				
				[teams addObject:team];				
				[team release];
			}
		}
		sqlite3_finalize(compiledStatement);	// Release the compiled statement from memory
		
		
		// Load the Goal Types...
		sqlStatement = "select id,name,description,points FROM goal_type ORDER BY id";		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			// Loop through the results and add them to the goalTypes array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
			{
				int aGoalTypeID			= [self getIntCol:compiledStatement index:0];
				NSString *aName			= [self getTextCol:compiledStatement index:1];
				NSString *aDescription	= [self getTextCol:compiledStatement index:2];
				int aPoints				= [self getIntCol:compiledStatement index:3];
				
				GoalType *goalType = [[GoalType alloc] initWithGoalTypeID:aGoalTypeID name:aName description:aDescription points:aPoints];
				
				[goalTypes addObject:goalType];				
				NSLog(@"Loaded goalType %i (name: %@, points: %i, description: %@)",aGoalTypeID,aName,aPoints,aDescription);
				[goalType release];
			}
		}
		sqlite3_finalize(compiledStatement);	// Release the compiled statement from memory
		
		
		// Load the matches and associated goals...
		sqlStatement = "SELECT m.id,m.name,m.description,m.home_team_id,m.away_team_id,DATE(m.date),TIME(m.kickoff),TIME(m.second_half),home_teams.name AS home_team_name, away_teams.name AS away_team_name "
						"FROM match AS m, team AS home_teams "
						"JOIN team AS away_teams ON away_teams.id=m.away_team_id WHERE home_teams.id=m.home_team_id "
						"ORDER BY m.date";
				
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			// Loop through the results and add them to the (local) matches array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
			{
				int aMatchID			= [self getIntCol:compiledStatement index:0];
				NSString *aMatchName	= [self getTextCol:compiledStatement index:1];
				NSString *aMatchDescr	= [self getTextCol:compiledStatement index:2];
				int aHomeTeamID			= [self getIntCol:compiledStatement index:3];
				int aAwayTeamID			= [self getIntCol:compiledStatement index:4];
				NSDate *aDate			= [self getDateCol:compiledStatement index:5];
				NSDate *aKickoff		= [self getTimeCol:compiledStatement index:6];
				NSDate *aSecondHalf		= [self getTimeCol:compiledStatement index:7];
				NSString *aHomeTeamName	= [self getTextCol:compiledStatement index:8];
				NSString *aAwayTeamName	= [self getTextCol:compiledStatement index:9];								
				
				// Log this prior to loading into the array (as well as after) because we also log from the loadGoals invocations below
				NSLog(@"Loading match %i (%@ v. %@)...",aMatchID,aHomeTeamName,aAwayTeamName);
				
				// Load both home and away goals for this match...
				NSMutableArray *aHomeGoals = [self loadGoals:database matchID:aMatchID homeTeamGoals:YES];
				NSMutableArray *aAwayGoals = [self loadGoals:database matchID:aMatchID homeTeamGoals:NO];

				// Now create the match object itself and add it to teh matches array...
				Match *match = [[Match alloc] initWithMatchID:aMatchID name:aMatchName description:aMatchDescr homeTeamID:aHomeTeamID awayTeamID:aAwayTeamID date:aDate kickoff:aKickoff secondHalf:aSecondHalf homeTeamName:aHomeTeamName awayTeamName:aAwayTeamName homeTeamGoals:aHomeGoals awayTeamGoals:aAwayGoals];				
				NSLog(@"...completed load of match %i",aMatchID);
				[matches addObject:match];
								
				[match release];
				[aHomeGoals release];
				[aAwayGoals release];
			}			
		}		
		sqlite3_finalize(compiledStatement);	// Release the compiled statement from memory		
		

		// Now loop through each team, building for each an array containing date-ordered matches it has played in. Once the
		// array is finished, it is added to a dictionary to allow us to hash into all games a particular team has played.
		for (Team *team in teams)
		{
			NSMutableArray *teamMatchesArray = [[NSMutableArray alloc] init];
				
			for (Match *match in matches)
			{
				if(team.teamID == match.homeTeamID || team.teamID == match.awayTeamID)
				{
					[teamMatchesArray addObject:match];
					NSLog(@"Team %@ participated in match %i (%@ v. %@)",team.name,match.matchID,match.homeTeamName,match.awayTeamName);
				}
			}
			[matchesByTeam setObject:teamMatchesArray forKey:team.name];
			[teamMatchesArray release];						
		}
		[matches release];
	}

	sqlite3_close(database);
}


-(NSMutableArray*)loadGoals:(sqlite3 *)db matchID:(int)mid homeTeamGoals:(BOOL)homeGoals
{
	NSMutableArray *goals = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStmt;
	
	NSString *sql = [[NSString alloc] initWithFormat:@"SELECT g.id,g.home_team_goal,g.goal_type,gt.name,gt.points,g.min FROM goal AS g,goal_type AS gt WHERE match_id=%i AND home_team_goal=%i AND g.goal_type=gt.id ORDER BY match_id, min", mid, homeGoals];
	if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &compiledStmt, NULL) == SQLITE_OK)
	{
		// Loop through the results and add them to the goals array
		while(sqlite3_step(compiledStmt) == SQLITE_ROW)
		{
			int		aGoalID			= [self getIntCol:compiledStmt index:0];
			BOOL	aHomeTeamGoal	= [self getBoolCol:compiledStmt index:1];
			int		aGoalType		= [self getIntCol:compiledStmt index:2];
			NSString *aGoalName		= [self getTextCol:compiledStmt index:3];
			int		aPoints			= [self getIntCol:compiledStmt index:4];
			int		aMinute			= [self getIntCol:compiledStmt index:5];
			Goal *goal = [[Goal alloc] initWithGoalID:aGoalID matchID:mid homeTeamGoal:aHomeTeamGoal goalType:aGoalType goalName:aGoalName points:aPoints minute:aMinute];

			[goals addObject:goal];				
			NSLog(@"- goal %i for match %i (homeTeamGoal %i, name %@, points %i, minute %i", aGoalID, mid, aHomeTeamGoal,aGoalName, aPoints, aMinute);					
			[goal release];
		}
	}
	sqlite3_finalize(compiledStmt);	// Release the compiled statement from memory
	return goals;
}

-(int)getIntCol:(sqlite3_stmt *)stmt index:(int)i
{
	return sqlite3_column_int(stmt, i);
}

-(BOOL)getBoolCol:(sqlite3_stmt *)stmt index:(int)i
{
	// BOOL values are held in Sqlite as integer 0 and 1, but we will be slightly less
	// exacting and assume that zero is false and non-zero is true...
	return ([self getIntCol:stmt index:i] == 0 ? NO : YES);	
}

-(NSString*)getTextCol:(sqlite3_stmt *)stmt index:(int)i
{
	const unsigned char *s = sqlite3_column_text(stmt, i);
	return s==NULL ? nil : [NSString stringWithUTF8String:(char *)s];
}

-(NSDate*)getDateCol:(sqlite3_stmt *)stmt index:(int)i
{
	NSString* str = [self getTextCol:stmt index:i];
	return str==nil ? nil : [SqliteDateFormatter dateFromString:str];
}

-(NSDate*)getTimeCol:(sqlite3_stmt *)stmt index:(int)i
{
	NSString* str = [self getTextCol:stmt index:i];
	return str==nil ? nil : [SqliteTimeFormatter dateFromString:str];
}

- (void)dealloc 
{
	[SqliteDateFormatter release];
	[SqliteTimeFormatter release];
	[teams release];
	[matchesByTeam release];
	[navigationController release];
	[window release];
	[super dealloc];
}

@end

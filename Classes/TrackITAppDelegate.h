#import <UIKit/UIKit.h>
#import <sqlite3.h> // Import the SQLite database framework

//
//  TrackITAppDelegate.h
//  TrackIT
//
//  Created by jonathan saville on 16/04/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface TrackITAppDelegate : NSObject
{		
	UIWindow *window;
	UINavigationController *navigationController;
		
	// Database variables
	NSString *databaseName;
	NSString *databasePath;
		
	// Array to store the match objects
	NSMutableArray *teams;
	NSMutableArray *goalTypes;
	NSMutableDictionary *matchesByTeam;
	
	NSDateFormatter *SqliteDateFormatter;
	NSDateFormatter *SqliteTimeFormatter;
}

-(void) checkAndCreateDatabase;
-(void) loadFromDatabase;
-(NSMutableArray*)loadGoals:(sqlite3 *)db matchID:(int)mid homeTeamGoals:(BOOL)homeGoals;

-(int)getIntCol:(sqlite3_stmt *)stmt index:(int)i;
-(BOOL)getBoolCol:(sqlite3_stmt *)stmt index:(int)i;
-(NSString*)getTextCol:(sqlite3_stmt *)stmt index:(int)i;
-(NSDate*)getDateCol:(sqlite3_stmt *)stmt index:(int)i;
-(NSDate*)getTimeCol:(sqlite3_stmt *)stmt index:(int)i;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *teams;
@property (nonatomic, retain) NSMutableArray *goalTypes;
@property (nonatomic, retain) NSMutableDictionary *matchesByTeam;
	
@end


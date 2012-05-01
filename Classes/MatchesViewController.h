//
//  MatchesViewController.h
//  TrackIT
//
//  Created by jonathan saville on 20/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Match.h"
#import "MatchViewController.h"

@interface MatchesViewController : UITableViewController {
	int teamID;
	MatchViewController *matchView;
}

- (NSString*)getGoalsStr:(NSMutableArray *)types match:(Match *)mtch homeTeam:(BOOL)home index:(int)idx;

@property(nonatomic) int teamID; 
@property(nonatomic, retain) MatchViewController *matchView; 

@end
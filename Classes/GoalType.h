//
//  GoalType.h
//  TrackIT
//
//  Created by jonathan saville on 23/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalType : NSObject
{
	int goalTypeID;
	NSString *name;
	NSString *description;
	int points;
}

@property (nonatomic) int goalTypeID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) int points;

-(id)initWithGoalTypeID:(int)gtid name:(NSString *)n description:(NSString *)d points:(int)p;

@end

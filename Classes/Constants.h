//
//  Constants.h
//  TrackIT
//
//  Created by jonathan saville on 20/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_TABLE_ROW_HEIGHT 30
#define DEFAULT_TABLE_FONT_SIZE 16

#define AppendString(A,B) [(A) stringByAppendingString:(B)]

extern NSString *const DEFAULT_TABLE_FONT_NAME;
extern NSString *const SQLITE_DATE_FORMAT;
extern NSString *const SQLITE_TIME_FORMAT;
extern NSString *const DATABASE_NAME;

@interface Constants : NSObject {
}

@end

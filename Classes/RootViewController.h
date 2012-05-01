#import <UIKit/UIKit.h>
#import "MatchesViewController.h"

@interface RootViewController : UITableViewController {
	MatchesViewController *matchesView;
}

@property(nonatomic, retain) MatchesViewController *matchesView; 

@end
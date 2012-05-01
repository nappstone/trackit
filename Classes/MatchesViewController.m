#import "Constants.h"
#import "RootViewController.h"
#import "TrackITAppDelegate.h"
#import "Match.h"
#import "GoalType.h"

@implementation MatchesViewController
@synthesize teamID,matchView;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TrackITAppDelegate *appDelegate = (TrackITAppDelegate *)[[UIApplication sharedApplication] delegate];

	// The count of relevant matches for this team is the row count of the team's matches array, that array is found in the matchesByTeam dictionary
	return [[appDelegate.matchesByTeam objectForKey:self.title] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	
    // Set up the cell
    TrackITAppDelegate *appDelegate = (TrackITAppDelegate *)[[UIApplication sharedApplication] delegate];

	// The match for this team is the row count of the team's matches array, that array is found in the matchesByTeam dictionary
	Match *match = (Match *)[[appDelegate.matchesByTeam objectForKey:self.title] objectAtIndex:indexPath.row];
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@" (dd MMM yyyy)"];
	NSString *d = [dateFormat stringFromDate:[match date]];
	[dateFormat release];
	
	cell.textLabel.text = AppendString(@"v. ", (self.teamID==match.homeTeamID ? match.awayTeamName : match.homeTeamName));
	cell.textLabel.text = AppendString(cell.textLabel.text, d);
	cell.textLabel.font = [UIFont fontWithName:DEFAULT_TABLE_FONT_NAME size:DEFAULT_TABLE_FONT_SIZE];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic -- create and push a new view controller
	TrackITAppDelegate *appDelegate = (TrackITAppDelegate *)[[UIApplication sharedApplication] delegate];
	Match *match = (Match *)[[appDelegate.matchesByTeam objectForKey:self.title] objectAtIndex:indexPath.row];
	
	if(self.matchView == nil) {
		MatchViewController *viewController = [[MatchViewController alloc] initWithNibName:@"MatchViewController" bundle:nil];
		self.matchView = viewController;
		[viewController release];
	}
	
	// Setup the animation
	[self.navigationController pushViewController:self.matchView animated:YES];
	
	// Leave the title of the view as blank - so here, we do not set 'self.matchView.title'
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEE, dd MMM yyyy"];
	NSString *dateString = [dateFormat stringFromDate:[match date]];
	[dateFormat setDateFormat:@"HH:mm:ss tt"];	// Can't get the AM/PM to appear - the 'tt' tag does not have any effect.
	//NSLog(@"date is %@", [dateFormat stringFromDate:[match kickoff]]);
	NSString *kickoffString = [dateFormat stringFromDate:[match kickoff]];
	[dateFormat release];
	
	// Set the data fields of the match object...
	[self.matchView.name setText:[match name]];
	[self.matchView.date setText:dateString];
	[self.matchView.description setText:[match description]];
	[self.matchView.kickoff setText:kickoffString];

	[self.matchView.homeTeam setText:[match homeTeamName]];
	[self.matchView.awayTeam setText:[match awayTeamName]];
	
	[self.matchView.homeScore setText:[match getTeamScoreStr:YES]];
	[self.matchView.awayScore setText:[match getTeamScoreStr:NO]];
	
	[self.matchView.homeGoals1 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:YES index:0]];
	[self.matchView.homeGoals2 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:YES index:1]];
	[self.matchView.homeGoals3 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:YES index:2]];
	[self.matchView.homeGoals4 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:YES index:3]];

	[self.matchView.awayGoals1 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:NO index:0]];
	[self.matchView.awayGoals2 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:NO index:1]];
	[self.matchView.awayGoals3 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:NO index:2]];
	[self.matchView.awayGoals4 setText:[self getGoalsStr:appDelegate.goalTypes match:match homeTeam:NO index:3]];
		
	return;
}

- (NSString*)getGoalsStr:(NSMutableArray *)types match:(Match *)mtch homeTeam:(BOOL)home index:(int)idx
{
	GoalType *goalType = [types objectAtIndex:idx];
	int goalCount = [mtch getTeamGoalCount:home goalType:goalType.goalTypeID];
	
	return [[NSString alloc] initWithFormat:@"%@(%i)", goalType.name, goalCount];		
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to add the Edit button to the navigation bar.
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// Override to support editing the list
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return DEFAULT_TABLE_ROW_HEIGHT;
}


/*
 // Override to support conditional editing of the list
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support rearranging the list
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the list
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 }
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end


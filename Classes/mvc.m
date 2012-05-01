#import "RootViewController.h"
#import "TrackITAppDelegate.h"
#import "Match.h"

@implementation MatchesViewController
@synthesize matchView;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TrackITAppDelegate *appDelegate = (TrackITAppDelegate *)[[UIApplication sharedApplication] delegate];
	return appDelegate.matches.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	
    // Set up the cell
    TrackITAppDelegate *appDelegate = (TrackITAppDelegate *)[[UIApplication sharedApplication] delegate];
	Match *match = (Match *)[appDelegate.matches objectAtIndex:indexPath.row];
	
	cell.textLabel.text = match.name;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic -- create and push a new view controller
	TrackITAppDelegate *appDelegate = (TrackITAppDelegate *)[[UIApplication sharedApplication] delegate];
	Match *match = (Match *)[appDelegate.matches objectAtIndex:indexPath.row];
	
	if(self.matchView == nil) {
		MatchViewController *viewController = [[MatchViewController alloc] initWithNibName:@"MatchViewController" bundle:nil];
		self.matchView = viewController;
		[viewController release];
	}
	
	// Setup the animation
	[self.navigationController pushViewController:self.matchView animated:YES];
	// Set the title of the view to the match's name
	self.matchView.title = [match name];
	
	return;
	
	/*
	// Set the description field to the matches description
	[self.matchView.matchDescription setText:[match description]];
	// Load the match's image into a NSData boject and then assign it to the UIImageView
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[match imageURL]]];
	UIImage *matchImage = [[UIImage alloc] initWithData:imageData cache:YES];
	self.matchView.matchImage.image = matchImage;
	*/
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to add the Edit button to the navigation bar.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.title = @"My Matches";
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


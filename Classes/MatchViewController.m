#import "MatchViewController.h"


@implementation MatchViewController

@synthesize name, date, description, homeTeam, awayTeam, kickoff, homeScore, awayScore;
@synthesize homeGoals1, homeGoals2, homeGoals3, homeGoals4;
@synthesize awayGoals1, awayGoals2, awayGoals3, awayGoals4,slider,sliderValue;

/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
    slider.transform=CGAffineTransformRotate(slider.transform,90.0/180*M_PI);
    
    
}



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

- (IBAction)sliderChanged:(id)sender
{
    
    [sliderValue setText:[NSString stringWithFormat:@"%2.2f",[slider value]]];
}
- (IBAction) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}
- (IBAction)touchDrag:(id)sender
{
    
}
@end

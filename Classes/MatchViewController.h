#import <UIKit/UIKit.h>

@interface MatchViewController : UIViewController
{
	IBOutlet UITextField *name;
	IBOutlet UITextField *date;
	IBOutlet UITextField *description;
	IBOutlet UITextField *homeTeam;
	IBOutlet UITextField *awayTeam;
	IBOutlet UITextField *kickoff;
	
	IBOutlet UITextField *homeScore;
	IBOutlet UITextField *awayScore;
	
	IBOutlet UITextField *homeGoals1;
	IBOutlet UITextField *homeGoals2;
	IBOutlet UITextField *homeGoals3;
	IBOutlet UITextField *homeGoals4;
	
	IBOutlet UITextField *awayGoals1;
	IBOutlet UITextField *awayGoals2;
	IBOutlet UITextField *awayGoals3;
	IBOutlet UITextField *awayGoals4;
	IBOutlet UITextField *sliderValue;
    IBOutlet UISlider    *slider;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *date;
@property (nonatomic, retain) IBOutlet UITextField *description;
@property (nonatomic, retain) IBOutlet UITextField *homeTeam;
@property (nonatomic, retain) IBOutlet UITextField *awayTeam;
@property (nonatomic, retain) IBOutlet UITextField *kickoff;
@property (nonatomic, retain) IBOutlet UITextField *homeScore;
@property (nonatomic, retain) IBOutlet UITextField *awayScore;
@property (nonatomic, retain) IBOutlet UITextField *homeGoals1;
@property (nonatomic, retain) IBOutlet UITextField *homeGoals2;
@property (nonatomic, retain) IBOutlet UITextField *homeGoals3;
@property (nonatomic, retain) IBOutlet UITextField *homeGoals4;
@property (nonatomic, retain) IBOutlet UITextField *awayGoals1;
@property (nonatomic, retain) IBOutlet UITextField *awayGoals2;
@property (nonatomic, retain) IBOutlet UITextField *awayGoals3;
@property (nonatomic, retain) IBOutlet UITextField *awayGoals4;
@property (nonatomic, retain) IBOutlet UITextField *sliderValue;
@property (nonatomic, retain) IBOutlet UISlider    *slider;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)touchDrag:(id)sender;
@end
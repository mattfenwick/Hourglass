#import "ViewController.h"
#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MWFCountdownState)
{
    MWFCountdownStateStopped,
    MWFCountdownStateRunning,
    MWFCountdownStatePaused
};


@interface ViewController ()

@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic) NSInteger countdownSecondsLeft;
@property (nonatomic) MWFCountdownState state;

@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UILabel *timeRemainingLabel;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.state = MWFCountdownStateStopped;
    self.startButton.backgroundColor = [UIColor redColor];
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)appDidBecomeActive:(NSNotification *)notification
{
    NSLog(@"view controller: app did become active");
}

- (void)appDidEnterBackground:(NSNotification *)notification
{
    NSLog(@"view controller: app did enter background");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"did receive memory warning");
}

- (void)dealloc
{
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - IBActions

- (IBAction)startButtonTapped:(id)sender
{
    NSLog(@"start button tapped");
    switch (self.state) {
        case MWFCountdownStateStopped:
            [self start];
            break;
        case MWFCountdownStatePaused:
            [self resume];
            break;
        case MWFCountdownStateRunning:
            [self pause];
            break;
    }
}

#pragma mark - countdown actions

- (void)start
{
    NSLog(@"start");
    self.countdownSecondsLeft = 15;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDecrement:) userInfo:nil repeats:YES];
    self.state = MWFCountdownStateRunning;
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"%ld", (long)self.countdownSecondsLeft];
    self.startButton.backgroundColor = [UIColor greenColor];
}

- (void)pause
{
    NSLog(@"pause");
    self.state = MWFCountdownStatePaused;
    [self cancelCountdownTimer];
    self.startButton.backgroundColor = [UIColor yellowColor];
}

- (void)resume
{
    NSLog(@"resume");
    self.state = MWFCountdownStateRunning;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDecrement:) userInfo:nil repeats:YES];
    self.startButton.backgroundColor = [UIColor greenColor];
}

- (void)stop
{
    NSLog(@"stop");
    [self cancelCountdownTimer];
    self.state = MWFCountdownStateStopped;
}

#pragma mark - timer

- (void)timerDecrement:(NSTimer *)timer
{
    NSLog(@"decrement: %ld", (long)self.countdownSecondsLeft);
    if (self.countdownSecondsLeft > 0)
    {
        self.countdownSecondsLeft--;
        self.timeRemainingLabel.text = [NSString stringWithFormat:@"%ld", (long)self.countdownSecondsLeft];
    }
    else
    {
        [self stop];
        [self countdownDidFinish];
    }
}

#pragma mark - helpers

- (void)cancelCountdownTimer
{
    NSLog(@"cancel countdown timer");
    if (self.countdownTimer.valid)
    {
        [self.countdownTimer invalidate];
    }
    self.countdownTimer = nil;
}

- (void)countdownDidFinish
{
    NSLog(@"countdown did finish");
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"%d", 0];
    self.startButton.backgroundColor = [UIColor redColor];
    // TODO flash the UI or something
}

#pragma mark - orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end

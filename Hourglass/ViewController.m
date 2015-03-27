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
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    NSLog(@"dealloc");
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
    [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"time remaining: %ld", (long)self.countdownSecondsLeft];
}

- (void)pause
{
    NSLog(@"pause");
    self.state = MWFCountdownStatePaused;
    [self cancelCountdownTimer];
    [self.startButton setTitle:@"Resume" forState:UIControlStateNormal];
}

- (void)resume
{
    NSLog(@"resume");
    self.state = MWFCountdownStateRunning;
    [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDecrement:) userInfo:nil repeats:YES];
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
        self.timeRemainingLabel.text = [NSString stringWithFormat:@"time remaining: %ld", (long)self.countdownSecondsLeft];
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
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"time remaining: %d", 0];
    // TODO flash the UI or something
}

@end

#import "ViewController.h"
#import <Foundation/Foundation.h>


@interface ViewController ()

@property (nonatomic, strong) NSTimer *countdownTimer;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - actions

- (IBAction)start
{

}

- (IBAction)stop
{
    
}

- (IBAction)pause
{
    
}

#pragma mark - helpers

- (void)cancelCountdownTimer
{
    if (self.countdownTimer.valid)
    {
        [self.countdownTimer invalidate];
    }
    self.countdownTimer = nil;
}

@end

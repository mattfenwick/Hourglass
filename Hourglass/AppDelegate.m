#import "AppDelegate.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"did finish launching");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"did enter background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"will enter foreground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"did become active");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"will terminate");
}

@end

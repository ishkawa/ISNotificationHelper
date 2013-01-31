#import "ISAppDelegate.h"

@implementation ISAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    NSDistributedNotificationCenter *center = [NSDistributedNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(handleDistributedNotification:)
                   name:@"ISNotification"
                 object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    NSDistributedNotificationCenter *center = [NSDistributedNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)handleDistributedNotification:(NSNotification *)notification
{
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center removeAllDeliveredNotifications];
    
    NSUserNotification *userNotification = [[NSUserNotification alloc] init];
    userNotification.title = [notification.userInfo objectForKey:@"title"];
    userNotification.subtitle = [notification.userInfo objectForKey:@"subtitle"];
    userNotification.informativeText = [notification.userInfo objectForKey:@"informativeText"];
    
    [center deliverNotification:userNotification];
}

@end

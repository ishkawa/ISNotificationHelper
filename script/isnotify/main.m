#import <Foundation/Foundation.h>
#include <unistd.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        char opt;
        
        while((opt = getopt(argc, (char **)argv, "t:s:i:")) != -1){
            switch(opt){
                case 't': {
                    NSString *value = [NSString stringWithCString:optarg encoding:NSUTF8StringEncoding];
                    [userInfo setValue:value forKey:@"title"];
                    break;
                }
                case 's': {
                    NSString *value = [NSString stringWithCString:optarg encoding:NSUTF8StringEncoding];
                    [userInfo setValue:value forKey:@"subtitle"];
                    break;
                }
                case 'i': {
                    NSString *value = [NSString stringWithCString:optarg encoding:NSUTF8StringEncoding];
                    [userInfo setValue:value forKey:@"informativeText"];
                    break;
                }
                case '?': {
                    printf("usage: isnotify [<options>...]\n"
                           "options: -t title of notification\n"
                           "         -s subtitle of notication\n"
                           "         -i informative text of notication\n");
                    
                    return 1;
                }
            }
        }
        printf("%s\n", [[userInfo description] cStringUsingEncoding:NSUTF8StringEncoding]);
        
        NSDistributedNotificationCenter *center = [NSDistributedNotificationCenter defaultCenter];
        [center postNotificationName:@"ISNotification"
                              object:nil
                            userInfo:userInfo
                  deliverImmediately:YES];
    }
    return 0;
}


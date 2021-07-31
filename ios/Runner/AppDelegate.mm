#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#include "ClinkAPI.hpp"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    
    //定义sdk密钥。可从单实例控制面板的sdk密钥列表中获取。
    char* key="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";
    
    ClinkAPI api;
    int ret= api.start(key);
    
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

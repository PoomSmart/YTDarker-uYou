#import <UIKit/UIKit.h>
#import <dlfcn.h>

// Credit: level3tjg's uYou fix in uYouPlus

@interface YTAppDelegate : NSObject
@property (nonatomic, strong) id downloadsVC;
@end

static BOOL didFinishLaunching;

%hook YTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    didFinishLaunching = %orig;
    self.downloadsVC = [self.downloadsVC init];
    return didFinishLaunching;
}

%end

%hook DownloadsPagerVC

- (instancetype)init {
    return didFinishLaunching ? %orig : self;
}

%end

%ctor {
    dlopen("/Library/MobileSubstrate/DynamicLibraries/uYou.dylib", RTLD_LAZY);
    %init;
}
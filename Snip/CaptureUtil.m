//
//  CaptureUtil.m
//  Snip
//
//  Created by jinglong cai on 2021/4/7.
//  Copyright © 2021 isee15. All rights reserved.
//

#import "CaptureUtil.h"
#import "SnipManager.h"

@implementation CaptureUtil

+ (BOOL)checkPermission {
    if (@available(macOS 10.15, *)) {
        CFArrayRef windowList = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
        NSUInteger numberOfWindows = (NSUInteger) CFArrayGetCount(windowList);
        NSUInteger numberOfWindowsWithInfoGet = 0;
        for (int idx = 0; idx < numberOfWindows; idx++) {

            NSDictionary *windowInfo = (NSDictionary *) CFArrayGetValueAtIndex(windowList, idx);
            NSString *windowName = windowInfo[(id) kCGWindowName];
            NSNumber *sharingType = windowInfo[(id) kCGWindowSharingState];

            if (windowName || kCGWindowSharingNone != sharingType.intValue) {
                numberOfWindowsWithInfoGet++;
            } else {
                NSNumber *pid = windowInfo[(id) kCGWindowOwnerPID];
                NSString *appName = windowInfo[(id) kCGWindowOwnerName];
                NSLog(@"windowInfo get Fail pid:%lu appName:%@", pid.integerValue, appName);
            }
        }
        CFRelease(windowList);
        return numberOfWindows == numberOfWindowsWithInfoGet;
    }
    return YES;
}

+ (void)capture {
    if ([self checkPermission]) {
        [[SnipManager sharedInstance] startCapture];
    } else {
        NSURL *URL = [NSURL URLWithString:@"x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture"];
        [[NSWorkspace sharedWorkspace] openURL:URL];
    }
}

+ (void)quit {
    [NSApp terminate:NULL];
}

@end

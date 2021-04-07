//
//  DemoViewController.m
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "DemoViewController.h"
#import "SnipManager.h"
#import "CaptureUtil.h"

@interface DemoViewController ()
@property(weak) IBOutlet NSImageView *backImageView;

@end

@implementation DemoViewController

- (void)awakeFromNib {
    // Do view setup here.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEndCapture:) name:kNotifyCaptureEnd object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)onCapture:(id)sender {
    [CaptureUtil capture];
}

- (BOOL)screeningRecordPermissionCheck {
    if (@available(macOS 10.15, *)) {
        CFArrayRef windowList = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
        NSUInteger numberOfWindows = CFArrayGetCount(windowList);
        NSUInteger numberOfWindowsWithInfoGet = 0;
        for (int idx = 0; idx < numberOfWindows; idx++) {

            NSDictionary *windowInfo = (NSDictionary *)CFArrayGetValueAtIndex(windowList, idx);
            NSString *windowName = windowInfo[(id)kCGWindowName];
            NSNumber* sharingType = windowInfo[(id)kCGWindowSharingState];

            if (windowName || kCGWindowSharingNone != sharingType.intValue) {
                numberOfWindowsWithInfoGet++;
            } else {
                NSNumber* pid = windowInfo[(id)kCGWindowOwnerPID];
                NSString* appName = windowInfo[(id)kCGWindowOwnerName];
                NSLog(@"windowInfo get Fail pid:%lu appName:%@", pid.integerValue, appName);
            }
        }
        CFRelease(windowList);
        if (numberOfWindows == numberOfWindowsWithInfoGet) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (void)onEndCapture:(NSNotification *)notification {
    if (notification.userInfo[@"image"]) {
        self.backImageView.image = notification.userInfo[@"image"];
        return;
    }
    //    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    //    NSArray *classArray = [NSArray arrayWithObject:[NSImage class]];
    //    NSDictionary *options = [NSDictionary dictionary];
    //    BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
    //    if(ok) {
    //        NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];
    //        NSImage *image = [objectsToPaste objectAtIndex:0];
    //        self.backImageView.image = image;
    //        //[self.view.window setBackgroundColor:[NSColor colorWithPatternImage:image]];
    //    } else {
    //        NSLog(@"Error: Clipboard doesn't seem to contain an image.");
    //    }
}

- (IBAction)onStart:(id)sender {
    [CaptureUtil capture];
}

- (void) checkAndCapture{
    if ([self screeningRecordPermissionCheck]){
        [[SnipManager sharedInstance] startCapture];
    }else{
        NSURL *URL = [NSURL URLWithString:@"x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture"];
        [[NSWorkspace sharedWorkspace] openURL:URL];
    }
}

@end

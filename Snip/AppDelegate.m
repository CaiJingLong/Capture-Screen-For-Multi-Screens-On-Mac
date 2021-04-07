//
//  AppDelegate.m
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "AppDelegate.h"
#import "SnipManager.h"
#import "CaptureUtil.h"
#import "SingleContainer.h"

@interface AppDelegate ()

@property(weak) IBOutlet NSWindow *window;
@property(nonatomic, strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application

  NSStatusBar *systemStatusBar = NSStatusBar.systemStatusBar;
  NSStatusItem *item = [systemStatusBar statusItemWithLength:NSSquareStatusItemLength];
  self.statusItem = item;

  NSImage *image = [NSImage imageNamed:@"Shot"];
  item.button.image = image;

  NSMenu *menu = [NSMenu new];
  item.menu = menu;

  NSMenuItem *item1 = [[NSMenuItem alloc] initWithTitle:@"capture" action:@selector(capture) keyEquivalent:@"P"];
  NSMenuItem *item2 = [[NSMenuItem alloc] initWithTitle:@"quit" action:@selector(quit) keyEquivalent:@"q"];
  NSMenuItem *item3 = [[NSMenuItem alloc] initWithTitle:@"Change color" action:@selector(showPickColor) keyEquivalent:@"c"];

  [menu addItem:item1];
  [menu addItem:item3];
  [menu addItem:item2];
}

- (void)showPickColor {
  [SingleContainer.shared pickColor];
}

- (void)capture {
  [CaptureUtil capture];
}

- (void)quit {
  [CaptureUtil quit];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end

//
// Created by jinglong cai on 2021/4/7.
// Copyright (c) 2021 isee15. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "SingleContainer.h"

static SingleContainer *_singleContainer;

@implementation SingleContainer {

}

+ (instancetype)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _singleContainer = [SingleContainer new];
    _singleContainer.color = [NSColor redColor];
  });

  return _singleContainer;
}

- (void)changeColor:(NSColor *)color {
  self.color = color;
}


- (void)pickColor {
  NSColorPanel *panel = NSColorPanel.sharedColorPanel;
  panel.color = self.color;
  panel.mode = NSColorPanelModeRGB;
  [panel setAction:@selector(onChangeColor:)];
  [panel setTarget:self];
//  [panel setContinuous:YES];
  [panel orderFront:nil];
}

- (void)onChangeColor:(NSColorPanel *)panel {
  [self changeColor:panel.color];
}

@end

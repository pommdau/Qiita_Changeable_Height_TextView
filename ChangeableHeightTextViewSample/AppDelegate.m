//
//  AppDelegate.m
//  ChangeableHeightTextViewSample
//
//  Created by HIROKI IKEUCHI on 2019/05/22.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "AppDelegate.h"
#import "TextViewWindowController.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, readonly) TextViewWindowController *textViewWindowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    // ViewControllerの作成とウィンドウを表示
    TextViewWindowController *textViewWindowController = [[TextViewWindowController alloc] init];
    [textViewWindowController showWindow:self];
    _textViewWindowController = textViewWindowController;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end

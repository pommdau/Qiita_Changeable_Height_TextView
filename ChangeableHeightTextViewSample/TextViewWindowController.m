//
//  TextViewWindowController.m
//  HyperLinkWindow
//
//  Created by HIROKI IKEUCHI on 2019/05/17.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "TextViewWindowController.h"
#import "ChangeableHeightTextView.h"

@interface TextViewWindowController () <ChangeableHeightTextViewDelegate>
@property (unsafe_unretained) IBOutlet ChangeableHeightTextView *myTextView;

@end

@implementation TextViewWindowController

- (id)init {
    if (self = [super initWithWindowNibName:[self className] owner:self]) {
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [_myTextView didChangeText];    // 開始時にUIを更新しておく
}

// MARK:- TextView Delegate Methods
// TextView内のテキストが変更されたときに呼ばれる
- (void)ChangeableHeightTextViewDidChange {
    NSRect windowFrame = self.window.frame;
    NSRect scrollViewFrame = _myTextView.superview.superview.frame;
    // 20:Windowのヘッダ幅、上下のマージン、
    // 20:（入力していってね）の高さ
    // 6 :固定テキストとNSSCrollViewの間隔
    windowFrame.size.height = (20 + 20 + 6 + 20 + 20) + scrollViewFrame.size.height;
    [self.window setFrame:windowFrame display:YES];
}

@end

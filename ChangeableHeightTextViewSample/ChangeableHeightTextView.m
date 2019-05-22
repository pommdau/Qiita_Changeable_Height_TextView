//
//  ChangeableHeightTextView.m
//  HyperLinkWindow
//
//  Created by HIROKI IKEUCHI on 2019/05/20.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "ChangeableHeightTextView.h"

static const int kInitialStringHeight     = 19; // 1行目の文字列の高さ
static const int kSingleByteStringHeight  = 14; // 非日本語文字列の高さ（FontSiZeが12のとき）
//static const int kMultiByteStringHeight   = 18; // 日本語文字列の高さ　（FontSiZeが12のとき）
static const int kMaximumLineNum          = 100; // この行数以上では高さを変更しない

@interface ChangeableHeightTextView()
@end

@implementation ChangeableHeightTextView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    // 見やすいようにNSTextViewの範囲を描画する
    NSRect bounds = [self bounds];
    [[NSColor greenColor] set];
    [NSBezierPath strokeRect:bounds];
}

/**
 @brief NSTextViewの含まれるNSSCrollViewのframeのheightを更新する
 */
- (void)updateScrollViewHeight {
    // Calculate height
    NSUInteger numberOfLines = [self numberOfLines];
    NSUInteger height = 0;
    if (numberOfLines <= kMaximumLineNum) {
        height = kInitialStringHeight + (numberOfLines - 1) * kSingleByteStringHeight;  // 1行目の高さは固定としている
        if (height < kInitialStringHeight) {
            height = kInitialStringHeight;  // 最低の幅を設定
        }
    }
    
    // Update height
    NSScrollView *scrollView = (NSScrollView *) self.superview.superview;
    NSRect frame      = scrollView.frame;
    frame.size.height = height;
    scrollView.frame  = frame; // 実際のNSScrollViewのframeを更新
}

// テキストの変更時に呼ばれる
- (void)didChangeText
{
    [self updateScrollViewHeight];  // TextViewの含まれるNSSCrollViewのframeのheightを更新する
    [self.delegate ChangeableHeightTextViewDidChange];   // 呼び出し元のWindowControllerでウィンドウの高さを変更する
}

/**
 @brief NSTextViewの文字列の行数を計算する
 */
- (NSInteger)numberOfLines {
    NSLayoutManager *layoutManager = [self layoutManager];
    NSUInteger      numberOfLines  = 0;     // 行数のカウント用変数
    NSUInteger      numberOfGlyphs = [layoutManager numberOfGlyphs];
    NSRange         lineRange;  // 現在対象となっている行の、先頭の開始位置と文字数
    for (NSUInteger index = 0; index < numberOfGlyphs; numberOfLines++) {   // index: 現在見ている文字の位置
        (void) [layoutManager lineFragmentRectForGlyphAtIndex:index
                                               effectiveRange:&lineRange];
        index = NSMaxRange(lineRange);
    }
    
    // 最終行が改行の場合に計算されていないようなので、その補正をする
    NSString *text = self.textStorage.string;
    if (text.length != 0 && [[text substringFromIndex:text.length - 1] isEqualToString:@"\n"]) {
        numberOfLines++;
    }
    return numberOfLines;
}

@end

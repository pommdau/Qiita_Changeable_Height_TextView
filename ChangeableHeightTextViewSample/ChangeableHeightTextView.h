//
//  ChangeableHeightTextView.h
//  HyperLinkWindow
//
//  Created by HIROKI IKEUCHI on 2019/05/20.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ChangeableHeightTextViewDelegate <NSTextViewDelegate>
- (void)ChangeableHeightTextViewDidChange;  // テキストビューの内容が変更されたときによばれる
@end
@interface ChangeableHeightTextView : NSTextView
@property (weak, nonatomic) id <ChangeableHeightTextViewDelegate> delegate;
- (void)updateScrollViewHeight;
@end

NS_ASSUME_NONNULL_END


#import <UIKit/UIKit.h>
#import "UIView_TouchHighlighting/MTCompoundButton.h"

@class TLBView;

@protocol TLBViewDelegate
- (void)twoLabelButtons:(TLBView*)twoLabelButtons didSelected:(NSUInteger)index;
@end

@protocol TLBViewDataSource
- (NSString*)twoLabelButtons:(TLBView*)twoLabelButtons firstTitle:(NSUInteger)index;
- (NSString*)twoLabelButtons:(TLBView*)twoLabelButtons secondTitle:(NSUInteger)index;
@end

IB_DESIGNABLE
@interface TLBButton : MTCompoundButton
@property (nonatomic) IBInspectable CGFloat  fontSize;
@property (nonatomic) IBInspectable UIColor *firstColor;
@property (nonatomic) IBInspectable UIColor *secondColor;
@property (nonatomic) IBInspectable CGFloat  cornerRadius;
@property (nonatomic) IBInspectable NSString *firstTitle;
@property (nonatomic) IBInspectable NSString *secondTitle;
@end

IB_DESIGNABLE
@interface TLBView : UIControl
@property (nonatomic) id<TLBViewDelegate>    delegate;
@property (nonatomic) id<TLBViewDataSource>  datasource;
@property (nonatomic) IBInspectable CGFloat  fontSize;
@property (nonatomic) IBInspectable UIColor *firstColor;
@property (nonatomic) IBInspectable UIColor *secondColor;
@property (nonatomic) IBInspectable CGFloat  cornerRadius;
@property (nonatomic) IBInspectable CGFloat  spacing;
- (void)reload;
@end


#import "TwoLabelButtons.h"
#import "MTCompoundButton.h"
#import "PureLayout.h"

@interface TLBLabel : UILabel
@end
@implementation TLBLabel
- (void)drawTextInRect:(CGRect)rect {
  UIEdgeInsets insets = {0,8,0,8};
  [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end

IB_DESIGNABLE
@interface TLBButton : MTCompoundButton {
@private
  TLBLabel *_firstLabel;
  TLBLabel *_secondLabel;
}
@property (nonatomic) IBInspectable CGFloat  fontSize;
@property (nonatomic) IBInspectable UIColor *firstColor;
@property (nonatomic) IBInspectable UIColor *secondColor;
@property (nonatomic) IBInspectable CGFloat  cornerRadius;
@property (nonatomic) IBInspectable NSString *firstTitle;
@property (nonatomic) IBInspectable NSString *secondTitle;
@end

@implementation TLBButton

- (instancetype)init {
  if (self = [super init]) {
    [self setupDefaults];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setupDefaults];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setupDefaults];
  }
  return self;
}

- (void)setupDefaults {
  _firstLabel  = [TLBLabel new];
  _secondLabel = [TLBLabel new];
  UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectZero];
  stack.axis = UILayoutConstraintAxisVertical;
  stack.alignment = UIStackViewAlignmentFill;
  stack.distribution = UIStackViewDistributionFillEqually;
  [stack addArrangedSubview:_firstLabel];
  [stack addArrangedSubview:_secondLabel];
  [self addSubview:stack];
  [stack autoPinEdgesToSuperviewEdges];
  stack.userInteractionEnabled = NO;
}

- (void)setFirstColor:(UIColor *)firstColor {
  if (firstColor != _firstColor) {
    _firstColor = firstColor;
    _firstLabel.backgroundColor = firstColor;
  }
}

- (void)setSecondColor:(UIColor *)secondColor {
  if (secondColor != _secondColor) {
    _secondColor = secondColor;
    _secondLabel.backgroundColor = secondColor;
  }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  if (cornerRadius != _cornerRadius) {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
  }
}

- (void)setFontSize:(CGFloat)fontSize {
  if (fontSize != _fontSize) {
    _fontSize = fontSize;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    _firstLabel.font  = font;
    _secondLabel.font = font;
  }
}

- (void)setFirstTitle:(NSString *)firstTitle {
  _firstLabel.text = firstTitle;
}

- (void)setSecondTitle:(NSString *)secondTitle {
  _secondLabel.text = secondTitle;
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  UIColor *textColor = (enabled) ? [UIColor blackColor] : [UIColor darkGrayColor];
  _firstLabel.textColor  = textColor;
  _secondLabel.textColor = textColor;
}

@end

@interface TLBView () {
@private
  NSArray<TLBButton*> *_buttons;
  UIStackView *_stack;
}
@end

@implementation TLBView

const int kButtonsCount = 3;

- (instancetype)init {
  if (self = [super init]) {
    [self setupDefaults];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setupDefaults];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setupDefaults];
  }
  return self;
}

- (void)setupDefaults {
  _buttons = [self makeButtons];
  _stack = [UIStackView new];
  _stack.axis = UILayoutConstraintAxisVertical;
  _stack.alignment = UIStackViewAlignmentFill;
  _stack.distribution = UIStackViewDistributionFillEqually;
  [self forEachButton:^(TLBButton *button) {
    [_stack addArrangedSubview:button];
  }];
  [self addSubview:_stack];
  [_stack autoPinEdgesToSuperviewEdges];
}

- (NSArray<TLBButton*>*)makeButtons {
  NSMutableArray<TLBButton*> *array = [[NSMutableArray alloc] initWithCapacity:kButtonsCount];
  for (int i = 0; i < kButtonsCount; ++i) {
    TLBButton *button = [TLBButton new];
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [array addObject:button];
    button.tag = i;
  }
  return array;
}

- (void)onButtonClick:(TLBButton*)sender {
  [self.delegate twoLabelButtons:self didSelected:sender.tag];
}

- (void)setFontSize:(CGFloat)fontSize {
  if (_fontSize != fontSize) {
    _fontSize = fontSize;
    [self forEachButton:^(TLBButton *button) {
      button.fontSize = fontSize;
    }];
  }
}

- (void)setFirstColor:(UIColor *)firstColor {
  if (_firstColor != firstColor) {
    [self forEachButton:^(TLBButton *button) {
      button.firstColor = firstColor;
    }];
  }
}

- (void)setSecondColor:(UIColor *)secondColor {
  if (_secondColor != secondColor) {
    [self forEachButton:^(TLBButton *button) {
      button.secondColor = secondColor;
    }];
  }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  if (_cornerRadius != cornerRadius) {
    [self forEachButton:^(TLBButton *button) {
      button.cornerRadius = cornerRadius;
    }];
  }
}

- (void)forEachButton:(void (^)(TLBButton *button))apply {
  for (TLBButton *button in _buttons) {
    apply(button);
  }
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  [self forEachButton:^(TLBButton *button) {
    button.enabled = enabled;
  }];
}

- (void)setSpacing:(CGFloat)spacing {
  if (_spacing != spacing) {
    _spacing = spacing;
    _stack.spacing = spacing;
  }
}

- (void)reload {
  for (int i = 0; i < kButtonsCount; ++i) {
    _buttons[i].firstTitle  = [self.datasource twoLabelButtons:self firstTitle:i];
    _buttons[i].secondTitle = [self.datasource twoLabelButtons:self secondTitle:i];
  }
}

@end

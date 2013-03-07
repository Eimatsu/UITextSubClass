//
//  UITextViewWithToolbar.m
//  diseases
//
//  Created by azu on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UITextViewWithToolbar.h"

@implementation UITextViewWithToolbar {
}

@synthesize placeholderText = _placeholderText;
@synthesize placeholder = _placeholder;



#pragma mark - toolbar
- (void)done {
    [self resignFirstResponder];
}

- (UIView *)inputAccessoryView {
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
        target:nil action:nil];

    UIBarButtonItem *doneButton;
    doneButton = [[UIBarButtonItem alloc] init];
    doneButton.tintColor = nil;
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.title = NSLocalizedString(@"Done", @"Done");
    doneButton.target = self;
    doneButton.action = @selector(done);
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:centerSpace, doneButton, nil]];
    return keyboardDoneButtonView;
}

#pragma mark - placeholder
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupPlaceholder {
    if ([self placeholder]){
        return;
    }

    CGRect frame = CGRectMake(8, 8, self.bounds.size.width - 16, 0.0);
    self.placeholder = [[UILabel alloc] initWithFrame:frame];
    [self.placeholder setLineBreakMode:NSLineBreakByWordWrapping];
    [self.placeholder setNumberOfLines:0];
    [self.placeholder setBackgroundColor:[UIColor clearColor]];
    [self.placeholder setAlpha:1.0];
    [self.placeholder setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.placeholder setTextColor:[UIColor lightGrayColor]];
    [self addSubview:self.placeholder];
    [self sendSubviewToBack:self.placeholder];

    [self setPlaceholder:self.placeholder];

    [[NSNotificationCenter defaultCenter]
                           addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]
                           addObserver:self selector:@selector(gotFocus:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter]
                           addObserver:self selector:@selector(lostFocus:) name:UITextViewTextDidEndEditingNotification object:nil];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupPlaceholder];
    [self setUpStyle];
}

- (void)setUpStyle {
// style customize - https://github.com/tomohisa/JTCCustomizableUIComponent
    if (_borderColor){
        self.layer.borderColor = _borderColor.CGColor;
    }
    if (_shadowColor){
        self.layer.shadowColor = _shadowColor.CGColor;
    }
    if (_shadowOpacity){
        self.layer.shadowOpacity = [_shadowOpacity floatValue];
    }
    if (_borderWidth){
        self.layer.borderWidth = [_borderWidth floatValue];
    }
    if (_shadowRadius){
        self.layer.shadowRadius = [_shadowRadius floatValue];
    }
    if (_cornerRadius){
        self.layer.cornerRadius = [_cornerRadius floatValue];
    }
    if (_shadowOffset){
        self.layer.shadowOffset = [_shadowOffset CGSizeValue];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setupPlaceholder];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        [self setupPlaceholder];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification {
    if ([[self.placeholder text] length] == 0){
        return;
    }

    if ([[self text] length] == 0){
        [self.placeholder setAlpha:1.0];
    } else {
        [self.placeholder setAlpha:0.0];
    }
}

- (void)gotFocus:(NSNotification *)notification {
    [self.placeholder setAlpha:0.0];
}

- (void)lostFocus:(NSNotification *)notification {
    if ([[self text] length] == 0){
        [self.placeholder setAlpha:1.0];
    } else {
        [self.placeholder setAlpha:0.0];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if ([[self text] length] == 0 && [[self.placeholder text] length] > 0){
        [self.placeholder setAlpha:1.0];
    } else {
        [self.placeholder setAlpha:0.0];
    }

}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self.placeholder setFont:self.font];
}


- (void)setPlaceholderText:(NSString *)placeholderText {
    [self.placeholder setText:placeholderText];
    [self.placeholder sizeToFit];

}

- (UIColor *)placeholderColor {
    return [self.placeholder textColor];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    [self.placeholder setTextColor:placeholderColor];
}
@end
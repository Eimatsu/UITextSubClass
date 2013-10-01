//
//  Created by azu on 12/07/06.
//


#import <Foundation/Foundation.h>
#import "UITextFieldWithPickerBase.h"

@protocol UITextFieldWithPickerProtocol;


@interface UITextFieldWithPicker : UITextFieldWithPickerBase <UIPickerViewDelegate>

@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, weak) NSObject <UITextFieldWithPickerProtocol> *myDelegate;

- (NSString *)selectedValue;

@end
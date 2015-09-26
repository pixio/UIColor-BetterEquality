//
//  UIColor+Equality.m
//
//  Created by Daniel Blakemore on 9/5/13.
//
//  Copyright (c) 2015 Pixio
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIColor+BetterEquality.h"

#define COLOR_COMP_EPS (0.5/255)
#define cmpComp(a, b) (fabs(a - b) < COLOR_COMP_EPS)

@implementation UIColor (BetterEquality)

- (BOOL)isEqualToColor:(UIColor *)otherColor 
{
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    const CGFloat *(^getComponents)(UIColor*) = ^(UIColor *color) {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            CGColorRef colorRef = CGColorCreate( colorSpaceRGB, components );
            
            UIColor * rgbColor = [UIColor colorWithCGColor:colorRef];
            CGColorRelease(colorRef);
            return CGColorGetComponents(rgbColor.CGColor);            
        } else {
            return CGColorGetComponents(color.CGColor);
        }
    };
    
    const CGFloat * myComponents = getComponents(self);
    const CGFloat * otherComponents = getComponents(otherColor);
    
    BOOL equality = myComponents && otherComponents &&
    (   cmpComp(myComponents[0], otherComponents[0])
     && cmpComp(myComponents[1], otherComponents[1])
     && cmpComp(myComponents[2], otherComponents[2]));
    
//    NSLog(@"Comparing these colors\na:%1.6f, %1.6f, %1.6f\nb:%1.6f, %1.6f, %1.6f\nVerdict:         %@", myComponents[0], myComponents[1], myComponents[2], otherComponents[0], otherComponents[1], otherComponents[2], equality ? @"Equal" : @"Unequal");
    
    return equality;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[UIColor class]]) {
        return FALSE;
    } else {
        return [self isEqualToColor:object];
    }
}

@end

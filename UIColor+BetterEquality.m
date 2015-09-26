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
#define cmpComp(a, b) (fabs((a) - (b)) < COLOR_COMP_EPS)

@implementation UIColor (BetterEquality)

- (BOOL)isEqualToColor:(UIColor *)otherColor 
{    
    const BOOL (^getComponents)(UIColor*, CGFloat*) = ^BOOL(UIColor *color, CGFloat* array) {
        CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace([color CGColor]));
        if (model == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            array[0] = array[1] = array[2] = oldComponents[0];
            array[3] = oldComponents[1];
        } else if (model == kCGColorSpaceModelRGB) {
            const CGFloat* oldComponents = CGColorGetComponents(color.CGColor);
            for (int i = 0; i < 4; i++) {
                array[i] = oldComponents[i];
            }
        } else {
            return FALSE;
        }
        return TRUE;
    };
    
    CGFloat myComponents[4];
    BOOL iHaveComponents = getComponents(self, myComponents);
    CGFloat otherComponents[4];
    BOOL theyHaveComponents = getComponents(otherColor, otherComponents);
    
    BOOL equality = iHaveComponents && theyHaveComponents &&
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

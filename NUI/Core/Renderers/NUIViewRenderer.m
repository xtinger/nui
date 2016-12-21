//
//  NUIViewRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUIViewRenderer.h"
#import "NUIConstants.h"

@implementation NUIViewRenderer

+ (void)render:(UIView*)view withClass:(NSString*)className
{
//    if ([className isEqualToString:@"TopicHeaderView"]){
//        int i = 1;
//    }
    
    if ([NUISettings hasProperty:@"background-image" withClass:className]) {
        if ([NUISettings hasProperty:@"background-repeat" withClass:className] && ![NUISettings getBoolean:@"background-repeat" withClass:className]) {
            view.layer.contents = (__bridge id)[NUISettings getImage:@"background-image" withClass:className].CGImage;
        } else {
            [view setBackgroundColor: [NUISettings getColorFromImage:@"background-image" withClass: className]];
        }
    } else if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        [view setBackgroundColor: [NUISettings getColor:@"background-color" withClass: className]];
    }
    
    //XG
    [self renderGradient:view withClass:className];

    //XG
    if ([NUISettings hasProperty:@"layout-margins" withClass:className]) {
        //view.preservesSuperviewLayoutMargins = YES;
        view.layoutMargins = [NUISettings getEdgeInsets:@"layout-margins" withClass:className];
        [view setNeedsLayout];
    }
    
    //XG
    if ([NUISettings hasProperty:@"tint-color" withClass:className]) {
        [view setTintColor:[NUISettings getColor:@"tint-color" withClass:className]];
    }
    
    [self renderSize:view withClass:className];
    [self renderBorder:view withClass:className];
    [self renderShadow:view withClass:className];
}

+ (void)render:(UIView *)view withClass:(NSString *)className withSuffix:(NSString*)suffix
{
    if (![suffix isEqualToString:@""]) {
        className = [NSString stringWithFormat:@"%@%@", className, suffix];
    }
    
    [self render:view withClass:className];
}

+ (void)renderBorder:(UIView*)view withClass:(NSString*)className
{
    CALayer *layer = [view layer];
    
    if ([NUISettings hasProperty:@"border-color" withClass:className]) {
        [layer setBorderColor:[[NUISettings getColor:@"border-color" withClass:className] CGColor]];
    }
    
    if ([NUISettings hasProperty:@"border-width" withClass:className]) {
        [layer setBorderWidth:[NUISettings getFloat:@"border-width" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"corner-radius" withClass:className]) {
        [layer setCornerRadius:[NUISettings getFloat:@"corner-radius" withClass:className]];
        layer.masksToBounds = YES;
    }
}

+ (void)renderShadow:(UIView*)view withClass:(NSString*)className
{
    CALayer *layer = [view layer];
    
    if ([NUISettings hasProperty:@"shadow-radius" withClass:className]) {
        [layer setShadowRadius:[NUISettings getFloat:@"shadow-radius" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"shadow-offset" withClass:className]) {
        [layer setShadowOffset:[NUISettings getSize:@"shadow-offset" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"shadow-color" withClass:className]) {
        [layer setShadowColor:[NUISettings getColor:@"shadow-color" withClass:className].CGColor];
    }
    
    if ([NUISettings hasProperty:@"shadow-opacity" withClass:className]) {
        [layer setShadowOpacity:[NUISettings getFloat:@"shadow-opacity" withClass:className]];
    }
}

+ (void)renderSize:(UIView*)view withClass:(NSString*)className
{
    CGFloat height = view.frame.size.height;
    if ([NUISettings hasProperty:@"height" withClass:className]) {
        height = [NUISettings getFloat:@"height" withClass:className];
    }
    
    CGFloat width = view.frame.size.width;
    if ([NUISettings hasProperty:@"width" withClass:className]) {
        width = [NUISettings getFloat:@"width" withClass:className];
    }

    if (height != view.frame.size.height || width != view.frame.size.width) {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, width, height);
    }
}

+ (BOOL)hasShadowProperties:(UIView*)view withClass:(NSString*)className {
    
    BOOL hasAnyShadowProperty = NO;
    for (NSString *property in @[@"shadow-radius", @"shadow-offset", @"shadow-color", @"shadow-opacity"]) {
        hasAnyShadowProperty |= [NUISettings hasProperty:property withClass:className];
    }
    return hasAnyShadowProperty;
}

+ (void)renderGradient:(UIView*)view withClass:(NSString*)className {
    
    CAGradientLayer* gradientLayer = objc_getAssociatedObject(view, kNUIAssociatedXGGradientLayerKey);
    
    if ([NUISettings hasProperty:@"gradient-test" withClass:className] && [NUISettings getBoolean:@"gradient-test" withClass:className]) {

        if (!gradientLayer) {
            gradientLayer = [CAGradientLayer layer];
        }
        
        gradientLayer.frame = view.bounds;
        
        if ([NUISettings hasProperty:@"gradient-vertical" withClass:className] && ![NUISettings getBoolean:@"gradient-vertical" withClass:className]) {
            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        }
        else {
            gradientLayer.startPoint = CGPointMake(0.5, 0.0);
            gradientLayer.endPoint = CGPointMake(0.5, 1.0);
        }
        
        UIColor* colorFrom = [NUISettings hasProperty:@"gradient-color-from" withClass:className] ? ([NUISettings getColor:@"gradient-color-from" withClass:className] ?: [UIColor whiteColor]) : [UIColor whiteColor];
        
        UIColor* colorTo = [NUISettings hasProperty:@"gradient-color-to" withClass:className] ? ([NUISettings getColor:@"gradient-color-to" withClass:className] ?: [UIColor whiteColor]) : [UIColor whiteColor];
        
        gradientLayer.colors = @[(id)colorFrom.CGColor,
                                 (id)colorTo.CGColor];

        if (!objc_getAssociatedObject(view, kNUIAssociatedXGGradientLayerKey)) {
            objc_setAssociatedObject(view, kNUIAssociatedXGGradientLayerKey, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [view.layer insertSublayer:gradientLayer atIndex:0];
        }
        
        [gradientLayer setNeedsDisplay];
    }
    else if (gradientLayer) {
        objc_setAssociatedObject(view, kNUIAssociatedXGGradientLayerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [gradientLayer removeFromSuperlayer];
    }
}

@end

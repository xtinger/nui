//
//  NUIViewRenderer.h
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "NUISettings.h"

@interface NUIViewRenderer : NSObject

+ (void)render:(UIView*)view withClass:(NSString*)className;
+ (void)render:(UIView *)view withClass:(NSString *)className withSuffix:(NSString*)suffix;
+ (void)renderBorder:(UIView*)view withClass:(NSString*)className;
+ (void)renderShadow:(UIView*)view withClass:(NSString*)className;
+ (void)renderSize:(UIView*)view withClass:(NSString*)className;

//XG
+ (void)renderGradient:(UIView*)view withClass:(NSString*)className;

+ (BOOL)hasShadowProperties:(UIView*)view withClass:(NSString*)className;

@end

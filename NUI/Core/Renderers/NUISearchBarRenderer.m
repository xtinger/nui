//
//  NUISearchBarRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 1/11/13.
//  Copyright (c) 2013 Tom Benner. All rights reserved.
//

#import "NUISearchBarRenderer.h"

@implementation NUISearchBarRenderer

+ (void)render:(UISearchBar*)bar withClass:(NSString*)className
{
    //XG
    if ([NUISettings hasProperty:@"bar-tint-color" withClass:className]) {
        [bar setBarTintColor:[NUISettings getColor:@"bar-tint-color" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        [bar setBackgroundImage:[NUISettings getImageFromColor:@"background-color" withClass:className]];
    }
    
    /*
     The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
     and behaves as described for the tintColor property added to UIView.
     To tint the bar's background, please use -barTintColor.
     */
    if ([NUISettings hasProperty:@"tint-color" withClass:className]) {
        [bar setTintColor:[NUISettings getColor:@"tint-color" withClass:className]];
    }
    //same
    if ([NUISettings hasProperty:@"background-tint-color" withClass:className]) {
        [bar setTintColor:[NUISettings getColor:@"background-tint-color" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"background-color-top" withClass:className]) {
        UIImage *gradientImage = [NUIGraphics
                                          gradientImageWithTop:[NUISettings getColor:@"background-color-top" withClass:className]
                                          bottom:[NUISettings getColor:@"background-color-bottom" withClass:className]
                                          frame:bar.bounds];
        [bar setBackgroundImage:gradientImage];
    }
    
    if ([NUISettings hasProperty:@"background-image" withClass:className]) {
        [bar setBackgroundImage:[NUISettings getImage:@"background-image" withClass:className]];
    }
    
    // Render scope bar
    
    if ([NUISettings hasProperty:@"scope-background-color" withClass:className]) {
        [bar setScopeBarBackgroundImage:[NUISettings getImageFromColor:@"scope-background-color" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"scope-background-image" withClass:className]) {
        [bar setScopeBarBackgroundImage:[NUISettings getImage:@"scope-background-image" withClass:className]];
    }
    
    NSString *scopeBarClassName = [NSString stringWithFormat:@"SegmentedControl:%@ScopeBar", className];
    NSDictionary *titleTextAttributes = [NUIUtilities titleTextAttributesForClass:scopeBarClassName];
    
    if ([[titleTextAttributes allKeys] count] > 0) {
        [bar setScopeBarButtonTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    
    if ([NUISettings hasProperty:@"background-color" withClass:scopeBarClassName] ||
        [NUISettings hasProperty:@"border-color" withClass:scopeBarClassName]) {
        CALayer *layer = [NUIGraphics roundedRectLayerWithClass:scopeBarClassName size:bar.bounds.size];
        UIImage *normalImage = [NUIGraphics roundedRectImageWithClass:scopeBarClassName layer:layer];
        
        if ([NUISettings hasProperty:@"background-color-selected" withClass:scopeBarClassName]) {
            [layer setBackgroundColor:[[NUISettings getColor:@"background-color-selected" withClass:scopeBarClassName] CGColor]];
        }
        UIImage *selectedImage = [NUIGraphics roundedRectImageWithClass:scopeBarClassName layer:layer];
        [bar setScopeBarButtonBackgroundImage:normalImage forState:UIControlStateNormal];
        [bar setScopeBarButtonBackgroundImage:selectedImage forState:UIControlStateSelected];
        
        if ([NUISettings hasProperty:@"border-color" withClass:scopeBarClassName]) {
            [bar setScopeBarButtonDividerImage:[NUISettings getImageFromColor:@"border-color" withClass:scopeBarClassName] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
        }
    }
    
}

@end

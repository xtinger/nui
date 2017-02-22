//
//  UINavigationController+NUI.m
//  MeetingAt
//
//  Created by Denis Voronov on 22/02/2017.
//  Copyright © 2017 Emanor. All rights reserved.
//

#import "UINavigationController+NUI.h"
#import "UINavigationBar+NUI.h"
@import MessageUI;

@implementation UINavigationController (NUI)

- (void)override_setNavigationBar:(UINavigationBar*)bar {
    [self override_setNavigationBar:bar];
    if ([self isKindOfClass:[MFMailComposeViewController class]]) {
        self.navigationBar.nuiClass = kNUIClassNone;
    }
}

@end

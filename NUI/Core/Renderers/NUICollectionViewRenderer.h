//
//  NUITableViewRenderer.h
//  Pods
//
//  Created by Tobias Heinicke on 19.06.13.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "NUIGraphics.h"
#import "NUIRenderer.h"
#import "NUISettings.h"

@interface NUICollectionViewRenderer : NSObject

+ (void)render:(UICollectionView*)collectionView withClass:(NSString*)className;
+ (void)sizeDidChange:(UICollectionView*)collectionView;

@end


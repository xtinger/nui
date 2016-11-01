
#import "NUICollectionViewRenderer.h"

@implementation NUICollectionViewRenderer

+ (void)render:(UICollectionView*)collectionView withClass:(NSString*)className
{
    [self renderSizeDependentProperties:collectionView withClass:(NSString*)className];
}

+ (void)sizeDidChange:(UICollectionView*)collectionView
{
    [self renderSizeDependentProperties:collectionView withClass:collectionView.nuiClass];
}

+ (void)renderSizeDependentProperties:(UICollectionView*)collectionView withClass:(NSString*)className
{
    // Set background color
    if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        UIImage *colorImage = [NUISettings getImageFromColor:@"background-color" withClass:className];
        collectionView.backgroundView = [[UIImageView alloc] initWithImage:colorImage];

        // in iOS 7, the UITableView's backgroundView is drawn above the UIRefreshControl
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
            collectionView.backgroundView.layer.zPosition -= 1;
    }
    
    // Set background gradient
    if ([NUISettings hasProperty:@"background-color-top" withClass:className]) {
        UIImage *gradientImage = [NUIGraphics
                                  gradientImageWithTop:[NUISettings getColor:@"background-color-top" withClass:className]
                                  bottom:[NUISettings getColor:@"background-color-bottom" withClass:className]
                                  frame:collectionView.bounds];
        collectionView.backgroundView = [[UIImageView alloc] initWithImage:gradientImage];
    }
    
}

@end


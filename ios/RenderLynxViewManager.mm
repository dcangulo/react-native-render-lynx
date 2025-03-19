#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"

@interface RenderLynxViewManager : RCTViewManager
@end

@implementation RenderLynxViewManager

RCT_EXPORT_MODULE(RenderLynxView)

- (UIView *)view
{
  return [[UIView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString)

@end

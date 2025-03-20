#import "RenderLynxView.h"

#import "generated/RNRenderLynxViewSpec/ComponentDescriptors.h"
#import "generated/RNRenderLynxViewSpec/EventEmitters.h"
#import "generated/RNRenderLynxViewSpec/Props.h"
#import "generated/RNRenderLynxViewSpec/RCTComponentViewHelpers.h"

#import "RCTFabricComponentsPlugins.h"

#import <Lynx/LynxView.h>
#import "DemoLynxProvider.h"

using namespace facebook::react;

@interface RenderLynxView () <RCTRenderLynxViewViewProtocol>

@end

@implementation RenderLynxView {
    LynxView * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<RenderLynxViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RenderLynxViewProps>();
    _props = defaultProps;

    _view = [[LynxView alloc] initWithBuilderBlock:^(LynxViewBuilder *builder) {
      builder.config = [[LynxConfig alloc] initWithProvider:[[DemoLynxProvider alloc] init]];
    }];
    _view.preferredLayoutWidth = 300;
    _view.preferredLayoutHeight = 700;
    _view.layoutWidthMode = LynxViewSizeModeExact;
    _view.layoutHeightMode = LynxViewSizeModeExact;

    [_view loadTemplateFromURL:@"noimage.lynx" initData:nil];

    self.contentView = _view;
  }

  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<RenderLynxViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<RenderLynxViewProps const>(props);

    // if (oldViewProps.color != newViewProps.color) {
    //     NSString * colorToConvert = [[NSString alloc] initWithUTF8String: newViewProps.color.c_str()];
    //     [_view setBackgroundColor:[self hexStringToColor:colorToConvert]];
    // }

    [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> RenderLynxViewCls(void)
{
    return RenderLynxView.class;
}

// - hexStringToColor:(NSString *)stringToConvert
// {
//     NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
//     NSScanner *stringScanner = [NSScanner scannerWithString:noHashString];

//     unsigned hex;
//     if (![stringScanner scanHexInt:&hex]) return nil;
//     int r = (hex >> 16) & 0xFF;
//     int g = (hex >> 8) & 0xFF;
//     int b = (hex) & 0xFF;

//     return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
// }

@end

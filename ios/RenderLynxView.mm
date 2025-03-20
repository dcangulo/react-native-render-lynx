#import "RenderLynxView.h"

#import "generated/RNRenderLynxViewSpec/ComponentDescriptors.h"
#import "generated/RNRenderLynxViewSpec/EventEmitters.h"
#import "generated/RNRenderLynxViewSpec/Props.h"
#import "generated/RNRenderLynxViewSpec/RCTComponentViewHelpers.h"

#import "RCTFabricComponentsPlugins.h"

#import <Lynx/LynxView.h>
#import "RenderLynxTemplateProvider.h"

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
      builder.config = [[LynxConfig alloc] initWithProvider:[[RenderLynxTemplateProvider alloc] init]];
    }];
    _view.preferredLayoutWidth = 300;
    _view.preferredLayoutHeight = 700;
    _view.layoutWidthMode = LynxViewSizeModeExact;
    _view.layoutHeightMode = LynxViewSizeModeExact;

    self.contentView = _view;
  }

  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RenderLynxViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RenderLynxViewProps const>(props);

  if (oldViewProps.bundleName != newViewProps.bundleName) {
    NSString *bundleName = [[NSString alloc] initWithUTF8String: newViewProps.bundleName.c_str()];
    [_view loadTemplateFromURL:bundleName initData:nil];
  }

  [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> RenderLynxViewCls(void)
{
  return RenderLynxView.class;
}

@end

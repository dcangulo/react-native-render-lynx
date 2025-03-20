#import <Foundation/Foundation.h>

#import "RenderLynxTemplateProvider.h"

@implementation RenderLynxTemplateProvider

- (void)loadTemplateWithUrl:(NSString*)url onComplete:(LynxTemplateLoadBlock)callback {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:url ofType:@"bundle"];
  if (filePath) {
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:0 error:&error];
    if (error) {
      callback(nil, error);
    } else {
      callback(data, nil);
    }
  } else {
    NSError *urlError = [NSError errorWithDomain:@"com.lynx" code:400 userInfo:@{NSLocalizedDescriptionKey : @"Invalid URL."}];
    callback(nil, urlError);
  }
}

@end

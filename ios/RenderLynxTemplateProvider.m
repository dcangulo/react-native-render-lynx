#import <Foundation/Foundation.h>

#import "RenderLynxTemplateProvider.h"

@implementation RenderLynxTemplateProvider

- (void)loadTemplateWithUrl:(NSString*)url onComplete:(LynxTemplateLoadBlock)callback {
  if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
    NSURL *remoteURL = [NSURL URLWithString:url];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:remoteURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (error) {
        callback(nil, error);
      } else {
        callback(data, nil);
      }
    }];

    [task resume];
  } else {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[url stringByDeletingPathExtension] ofType:@"bundle"];
    if (filePath) {
      NSError *error;
      NSData *data = [NSData dataWithContentsOfFile:filePath options:0 error:&error];
      if (error) {
        callback(nil, error);
      } else {
        callback(data, nil);
      }
    } else {
      NSError *urlError = [NSError errorWithDomain:@"com.lynx" code:400 userInfo:@{NSLocalizedDescriptionKey : @"Invalid URL or file path."}];
      callback(nil, urlError);
    }
  }
}

@end

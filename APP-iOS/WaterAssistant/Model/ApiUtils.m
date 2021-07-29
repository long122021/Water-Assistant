//
//  ApiUtils.m
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import "ApiUtils.h"
#import "AFNetworking.h"

#define BASE_URL    @"https://nodejs-express-app-hrewx-2021-07-07.mybluemix.net/"

static inline id checkProtocol(id obj, SEL selector) {
    if (obj && [obj respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [obj performSelector:selector];
#pragma clang diagnostic pop
    }
    return nil;
}

@interface ApiUtils ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerial;
@end

@implementation ApiUtils

+ (instancetype)sharedInstance {
    static ApiUtils *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] init];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html", nil];
    }
    return _manager;
}

- (AFHTTPRequestSerializer *)httpRequestSerial {
    if (!_httpRequestSerial) {
        _httpRequestSerial = [AFHTTPRequestSerializer serializer];
        _httpRequestSerial.timeoutInterval = 30.0f;
    }
    return _httpRequestSerial;
}

- (void)sendRequest:(BaseRequest *)request result:(ApiBlock)result {
    NSURLRequest *urlRequest = [self prepareStartRequest:request];

    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:urlRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

        [self requestResultHandle:request response:responseObject error:error result:result statusCode:((NSHTTPURLResponse *)response).statusCode];
    }];
    [dataTask resume];
}

- (NSURLRequest *)prepareStartRequest:(BaseRequest *)request {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASE_URL, checkProtocol(request, @selector(urlBackEnd))];
    NSURLRequest *urlRequest = [self.httpRequestSerial requestWithMethod:checkProtocol(request, @selector(method)) URLString:urlStr parameters:checkProtocol(request, @selector(parameters)) error:nil];
    return urlRequest;
}

- (void)requestResultHandle:(BaseRequest *)request response:(id)responseObject error:(NSError *)error result:(ApiBlock)result statusCode:(NSInteger)statusCode {
    if (statusCode == 200) {
        
        if ([request respondsToSelector:@selector(extralResponseHandle:)]) {
            [request extralResponseHandle:responseObject];
        }
        if (result) {
            result(statusCode, nil);
        }
    }else {
        result(statusCode, error);
    }
}
@end

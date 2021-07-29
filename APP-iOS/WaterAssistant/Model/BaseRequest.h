//
//  BaseRequest.h
//  WaterAssistant
//
//  Created by hyl on 2021/7/15.
//

#import <Foundation/Foundation.h>
#import <YYKit/YYKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *const GET = @"GET";
static NSString *const POST = @"POST";
static NSString *const PUT = @"PUT";
static NSString *const DELETE = @"DELETE";
static NSString *const HEAD = @"HEAD";

@interface BaseRequest : NSObject

@property (nonatomic, strong)NSString* url;
- (NSString *)method;           // get/post....
- (NSString *)urlBackEnd;       // api
- (NSDictionary *)parameters;   //参数
- (void)extralResponseHandle:(id)response; //服务器回包数据的额外处理
@end

NS_ASSUME_NONNULL_END

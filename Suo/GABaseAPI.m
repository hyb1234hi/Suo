//
//  GABaseAPI.m
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseAPI.h"
#import <CoreServices/CoreServices.h>
#import <AFNetworking.h>


static NSString *const rootPath = @"http://www.suo.com";
@implementation GABaseAPI




// 默认 POST
- (NSURLRequest *)createRequestWithPath:(NSString*)path parameter:(NSDictionary *)parameter method:(NSString *)method{
    
    

    if ([method isEqualToString:@"GET"]) {
        __block NSString *api = [rootPath stringByAppendingPathComponent:path];
        [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *str = [NSString stringWithFormat:@"&%@=%@",key,obj];
            api = [api stringByAppendingString:str];
        }];
        
            //转码字符集
        NSCharacterSet *charSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        api = [api stringByAddingPercentEncodingWithAllowedCharacters:charSet];
        
        NSURL *url = [NSURL URLWithString:api];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:30.0];
        return request;
        
    }else{
            //post
        NSString *api = [rootPath stringByAppendingPathComponent:path];
        NSURL *url = [NSURL URLWithString:api];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:30.0];
        
        NSString *boundary = [self generateBoundaryString];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        
        NSData *fromData = [self createBodyWithBoundary:boundary parameters:parameter paths:nil fieldName:nil];
        [request setHTTPBody:fromData];
        
        NSString *length = [NSString stringWithFormat:@"%lu",fromData.length];
        [request setValue:length forHTTPHeaderField:@"Content-Length"];
        return request;
    }
    
}

- (NSString*)generateBoundaryString{
    return  [NSString stringWithFormat:@"--Boundary-%@",[NSUUID new].UUIDString];
}

- (NSData*)createBodyWithBoundary:(NSString*)boundary parameters:(NSDictionary*)parameters paths:(NSArray*)paths fieldName:(NSString*)fieldName{
    
    NSMutableData *httpBody = [NSMutableData data];
        // add params (all params are strings)
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, id parameterValue, BOOL *stop) {
        
            //NSLog(@"  value ===%@",parameterValue);
        if ([parameterValue  isKindOfClass:NSArray.class]) {
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@[]\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSMutableString *paraValue = [[NSMutableString alloc] init];
            for (NSString *value in parameterValue) {
                [paraValue appendString:[NSString stringWithFormat:@"%@,",value]];
//                [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//                [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@[]\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
//                [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            [httpBody appendData:[paraValue dataUsingEncoding:NSUTF8StringEncoding]];
            
        } if ([parameterValue isKindOfClass:UIImage.class]) {
            
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.png\"\r\n",parameterKey,parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[@"Content-Type=image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *data = UIImagePNGRepresentation(parameterValue);
            [httpBody appendData:data];
            [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            //[httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            
        } else{
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }];
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    return httpBody;
}

- (NSString *)mimeTypeForPath:(NSString *)path {
        // get a mime type for an extension using MobileCoreServices.framework
    
    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);
    
    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);
    
    CFRelease(UTI);
    
    return mimetype;
}

- (void)dataTaskWithRequest:(NSURLRequest *)request dataCallback:(CallBack)callBack{
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *json = [self serializationDataWithData:data response:response error:error];
        
//        NSLog(@"error -- %@",error);
//        NSLog(@"response = %@",response);
//        NSLog(@"data -- %@",data);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callBack) {
                callBack(json,response);
            }
        });
    }] resume];
}

- (NSDictionary*)serializationDataWithData:(NSData*)data response:(NSURLResponse*)response error:(NSError*)error {
    if (error) {
        NSLog(@"解析JSON数据 Error =%@",error.localizedDescription);
    }
    
    NSError *serialiError = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    
    switch (httpResponse.statusCode / 10) {
        case 20:
            return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serialiError];
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)fetchUserInfoWithKey:(NSString *)key completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=member_account&t=get_base_myself_info";
    
    NSMutableDictionary *payload = @[].mutableCopy;
    [payload setValue:key forKey:@"key"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}

@end

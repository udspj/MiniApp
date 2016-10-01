//
//  NetManager.m
//  RongYi
//
//  Created by wen yu on 13-5-23.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "NetManager.h"
#import "SBJsonParser.h"
#import "Utils.h"

static NetManager *_manager;


@implementation NetManager


#pragma mark - 获取单例
+ (id)sharedManager{
    if (!_manager) {
        _manager = [[NetManager alloc] init];
    }
    return _manager;
}


#pragma mark 获取请求参数字符串
- (NSString *) getParamWithParamArray : (NSArray*) _paramArray keyArray : (NSArray*) _keyArray
{
    NSMutableString *str = [[NSMutableString alloc]init];
    for (int i = 0; i < [_paramArray count]; i++) {
        [str appendString:[_keyArray objectAtIndex:i]];
        [str appendString:@"="];
        [str appendString:[_paramArray objectAtIndex:i]];
        if (i != [_paramArray count]-1) {
            
            [str appendString:@"&"];
        }
    }
    return str;
}

#pragma mark array to string
- (NSString*) arrayToString : (NSArray*) _array
{
    NSMutableString *codeStr = [NSMutableString string];
    for (int i = 0; i < _array.count; i++) {
        [codeStr appendFormat:@"%@",[_array objectAtIndex:i]];
        if (i < _array.count - 1) {
            [codeStr appendString:@","];
        }
    }
    if (!codeStr || [codeStr isEqualToString:@""])
    {
        return @"null";
    }
    return codeStr;
}


#pragma mark - 商家列表
- (void) getEstoreListWithCoord_x : (float) _coord_x
                          coord_y : (float) _coord_y
                          pageNum : (int) _pageNum
                           param0 : (NSString*) _param0
                           param1 : (NSString*) _param1
                           success:(void (^)(id responseDic))success
                           failure:(void(^)(id errorString))failure
{
    NSMutableArray *paramArray = [NSMutableArray array];
    NSMutableArray *keyArray = [NSMutableArray array];
    [paramArray addObject:[NSString stringWithFormat:@"%f",_coord_x]];
    [keyArray addObject:@"coordx"];
    [paramArray addObject:[NSString stringWithFormat:@"%f",_coord_y]];
    [keyArray addObject:@"coordy"];
    [paramArray addObject:[NSString stringWithFormat:@"%d",_pageNum]];
    [keyArray addObject:@"page"];
    [paramArray addObject:_param0];
    [keyArray addObject:@"industry"];
    [paramArray addObject:_param1];
    [keyArray addObject:@"distance"];
 
    NSString *paramStr = [self getParamWithParamArray:paramArray keyArray:keyArray];
    NSString *urlString = [NSString stringWithFormat:@"%@/wap/coord_api.php?%@",serverAddress,paramStr];
    [self sendRequestWithUrlString:urlString success:success failure:failure];
}
//api url/wap/coord_api.php?coordx=121.433037&coordy=31.354533&page=1&industry=1&distance=1
//0代表全部，1代表第一个筛选条件，依次类推



#pragma mark - 筛选1
- (void) getParam0ListWithSuccess:(void (^)(id responseDic))success
                          failure:(void(^)(id errorString))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/wap/select_api.php?action=industry",serverAddress];
    [self sendRequestWithUrlString:urlString success:success failure:failure];
}

#pragma mark - 筛选2
- (void) getParam1ListWithSuccess:(void (^)(id responseDic))success
                          failure:(void(^)(id errorString))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/wap/select_api.php?action=distance",serverAddress];
    [self sendRequestWithUrlString:urlString success:success failure:failure];
}

//api url/wap/select_api.php?action=industry 获取行业的筛选条件
//api url/wap/select_api.php?action=distance 获取距离


#pragma mark - wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
#
#pragma mark - wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww




#pragma mark - 网络get请求入口
- (void) sendRequestWithUrlString : (NSString*) _urlString
                           success:(void (^)(id responseDic)) _success
                           failure:(void(^)(id errorString)) _failure
{
    //_urlString = [Utils getEncodingWithUTF8:_urlString];
    httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [httpRequest setUseCookiePersistence:NO];
    [httpRequest startAsynchronous];
    NSLog(@"_urlString %@",_urlString);
    __weak ASIHTTPRequest* request = httpRequest;
    [httpRequest setCompletionBlock:^{
        NSUInteger location = [request.responseString rangeOfString:@"{"].location;
        NSUInteger length = [request.responseString length] - location;
        NSRange range = NSMakeRange(location, length);
        NSString *resoponse = [request.responseString substringWithRange:range];
        
        [request clearDelegatesAndCancel];
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        
        NSMutableDictionary *responseDic = [jsonParser objectWithString:resoponse error:&error];
        if (error) {
            _failure([error localizedDescription]);
            //[Utils hudFailHidden:[error localizedDescription]];
            return ;
        }
        if (responseDic == nil) {
            NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:@"网络连接出错",NSLocalizedDescriptionKey, nil];
            NSError *customError=[NSError errorWithDomain:@"RongYi" code:500 userInfo:userInfo];
            _failure(customError);
            //[Utils hudFailHidden:[customError description]];
        }else {
//            int status=[[responseDic objectForKey:@"state"] intValue];
//            if (status == 0) {
                //请求成功
                _success(responseDic);
//                if ([hudString isEqualToString:@""]) {
                
                    NSString *msg = [responseDic objectForKey:@"errorMsg"];
                    if ([msg isEqualToString:@"成功!"] || [msg isEqualToString:@"成功"] || [msg isEqualToString:@"成功！"] || [msg isEqualToString:@"接口调用成功！"] || [msg isEqualToString:@"接口调用成功!"]||[msg isEqualToString:@"接口参数调用成功"]) {
                         //[Utils hudSuccessHidden:@"成功！"];
                    }else{
                        //[Utils hudSuccessHidden:[responseDic objectForKey:@"errorMsg"]];
                    }
//                }else{
//                    //[Utils hudSuccessHidden:hudString];
//                    //[hudString setString:@""];
//                }
//            }else{
//                //请求失败
//                NSString *resultString=[responseDic objectForKey:@"errorMsg"];
//                _failure(resultString);
//                //[Utils hudFailHidden:resultString];
//            }
        }
    }];
    [request setFailedBlock:^{
        [request clearDelegatesAndCancel];
        NSString *errorMsg = @"网络连接失败";
        _failure(errorMsg);
        //[Utils hudFailHidden:errorMsg];
        //[hudString setString:@""];
    }];
}

#pragma mark - form的post请求入口
- (void) formRequestWithUrlString : (NSString*) _urlString
                     postParamDic : (NSDictionary*) _postParamDic
                           success:(void (^)(id responseDic)) _success
                           failure:(void(^)(id errorString)) _failure
{
    //_urlString = [Utils getEncodingWithUTF8:_urlString];
    ASIFormDataRequest *aRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [aRequest setUseCookiePersistence:NO];
    for (NSString *keyString in [_postParamDic allKeys]) {
        [aRequest addPostValue:[_postParamDic objectForKey:keyString] forKey:keyString];
    }
    [aRequest startAsynchronous];
    
    __weak ASIFormDataRequest* request = aRequest;
    [request setCompletionBlock:^{
        NSUInteger location = [request.responseString rangeOfString:@"{"].location;
        NSUInteger length = [request.responseString length] - location;
        NSRange range = NSMakeRange(location, length);
        NSString *resoponse = [request.responseString substringWithRange:range];
        
        
//        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSData *responseData = [request responseData];
//        NSString *str = [[NSString alloc] initWithData:responseData encoding:encode];
//        NSLog(@"_urlString : %@" , str);
        
        [request clearDelegatesAndCancel];
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        
        NSMutableDictionary *responseDic = [jsonParser objectWithString:resoponse error:&error];
        if (error) {
            _failure([error localizedDescription]);
            return ;
        }
        if (responseDic == nil) {
            NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:@"网络连接出错",NSLocalizedDescriptionKey, nil];
            NSError *customError=[NSError errorWithDomain:@"RongYi" code:500 userInfo:userInfo];
            _failure(customError);
        }else {
//            int status=[[responseDic objectForKey:@"state"] intValue];
//            if (status == 0) {
                //请求成功
                _success(responseDic);
//            }else{
//                //请求失败
//                NSString *resultString=[responseDic objectForKey:@"errorMsg"];
//                _failure(resultString);
//            }
        }
    }];
    [request setFailedBlock:^{
        [request clearDelegatesAndCancel];
        NSString *errorMsg = @"网络连接失败";
        _failure(errorMsg);
    }];
}

#pragma mark - form带图像参数的post请求入口
- (void) formDataRequestWithUrlString : (NSString *) _urlString
                         postParamDic : (NSDictionary *) _postParamDic
                         imageParamDic : (NSDictionary *) _imageParamDic
                           success:(void (^)(id responseDic)) _success
                           failure:(void(^)(id errorString)) _failure
{
    //_urlString = [Utils getEncodingWithUTF8:_urlString];
    NSLog(@"_urlString : %@" , _urlString);
    ASIFormDataRequest *aRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [aRequest setUseCookiePersistence:NO];
    if (_postParamDic) {
        for (NSString *keyString in [_postParamDic allKeys]) {
            [aRequest addPostValue:[_postParamDic objectForKey:keyString] forKey:keyString];
        }
    }
    for (NSString *keyString in [_imageParamDic allKeys]) {
//        [aRequest setData:UIImageJPEGRepresentation([_imageParamDic objectForKey:keyString], 1) withFileName:[NSString stringWithFormat:@"%@.jpg",[Utils getSystemDataTime]] andContentType:@"image/jpeg" forKey:keyString];
        [aRequest setData:UIImagePNGRepresentation([_imageParamDic objectForKey:keyString]) withFileName:[NSString stringWithFormat:@"%@.png",[Utils getSystemDataTime]] andContentType:@"image/png" forKey:keyString];
    }
    [aRequest startAsynchronous];
    __weak ASIFormDataRequest* request = aRequest;
    [request setCompletionBlock:^{
        NSLog(@"completion : %@" , request.responseString);
        NSUInteger location = [request.responseString rangeOfString:@"{"].location;
        NSUInteger length = [request.responseString length] - location;
        NSRange range = NSMakeRange(location, length);
        NSString *resoponse = [request.responseString substringWithRange:range];
        [request clearDelegatesAndCancel];
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        
        NSMutableDictionary *responseDic = [jsonParser objectWithString:resoponse error:&error];
        if (error) {
            _failure([error localizedDescription]);
            return ;
        }
        if (responseDic == nil) {
            NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:@"网络连接出错",NSLocalizedDescriptionKey, nil];
            NSError *customError=[NSError errorWithDomain:@"RongYi" code:500 userInfo:userInfo];
            _failure(customError);
        }else {
//            int status=[[responseDic objectForKey:@"state"] intValue];
//            if (status == 0) {
                //请求成功
                _success(responseDic);
//            }else{
//                //请求失败
//                NSString *resultString=[responseDic objectForKey:@"errorMsg"];
//                _failure(resultString);
//            }
        }
    }];
    [request setFailedBlock:^{
        [request clearDelegatesAndCancel];
        NSString *errorMsg = @"网络连接失败";
        _failure(errorMsg);
    }];
}


-(void)cancelAllURLRequest{
    //[httpRequest cancel];
    [httpRequest clearDelegatesAndCancel];
}


@end

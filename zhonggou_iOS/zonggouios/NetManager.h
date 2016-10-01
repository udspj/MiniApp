//
//  NetManager.h
//  RongYi
//
//  Created by wen yu on 13-5-23.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface NetManager : NSObject{
    ASIHTTPRequest *httpRequest;
}

+ (id)sharedManager;


#pragma mark - 商家列表
- (void) getEstoreListWithCoord_x : (float) _coord_x
                          coord_y : (float) _coord_y
                          pageNum : (int) _pageNum
                           param0 : (NSString*) _param0
                           param1 : (NSString*) _param1
                           success:(void (^)(id responseDic))success
                           failure:(void(^)(id errorString))failure;

#pragma mark - 筛选1
- (void) getParam0ListWithSuccess:(void (^)(id responseDic))success
                          failure:(void(^)(id errorString))failure;

#pragma mark - 筛选2
- (void) getParam1ListWithSuccess:(void (^)(id responseDic))success
                          failure:(void(^)(id errorString))failure;


-(void)cancelAllURLRequest;


@end

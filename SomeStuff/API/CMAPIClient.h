//
//  CMAPIClient.h
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface CMAPIClient : AFHTTPClient

+ (id)sharedInstance;

- (void)peopleWithSuccessBlock:(void(^)(NSArray *people))successBlock withErrorBlock:(void(^)(NSError *error))errorBlock;

@end

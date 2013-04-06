//
//  CMAPIClient.m
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMAPIClient.h"
#import "CMAppEnvironment.h"
#import "EasyMapping.h"
#import "CMMappings.h"

@implementation CMAPIClient

+ (id)sharedInstance
{
    static CMAPIClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[CMAPIClient alloc] initWithBaseURL: [NSURL URLWithString:[[CMAppEnvironment sharedInstance] apiURL]]];
        AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    });
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *) url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        self.parameterEncoding = AFJSONParameterEncoding;
        [self configureParseHeaders];
    }
    return self;
}

- (void)configureParseHeaders
{
    [self setDefaultHeader:@"X-Parse-Application-Id" value:[[CMAppEnvironment sharedInstance] parseAppID]];
    [self setDefaultHeader:@"X-Parse-REST-API-Key" value:[[CMAppEnvironment sharedInstance] parseRestKey]];
}

- (void)peopleWithSuccessBlock:(void (^)(NSArray *))successBlock withErrorBlock:(void (^)(NSError *))errorBlock
{
    [self getPath:@"people" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (operation.response.statusCode == 200 || operation.response.statusCode == 201) {
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"DATA: %@", data);
            NSArray *people = [EKMapper arrayOfObjectsFromExternalRepresentation:[data objectForKey:@"results"] withMapping:[CMMappings personMapping]];
            successBlock(people);
        } else {
            errorBlock(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
}

@end

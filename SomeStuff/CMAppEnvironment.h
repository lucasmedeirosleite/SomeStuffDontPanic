//
//  CMAppEnvironment.h
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMEnvironment.h"

@interface CMAppEnvironment : CMEnvironment

@property (nonatomic, copy) NSString *parseAppID;
@property (nonatomic, copy) NSString *parseRestKey;
@property (nonatomic, copy) NSString *apiURL;

@end

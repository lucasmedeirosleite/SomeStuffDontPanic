//
//  CMPerson.h
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATModel.h"

typedef enum {
    CMGenderMale = 1,
    CMGenderFemale = 2
} CMGender;

@interface CMPerson : ATModel

@property (nonatomic, copy)   NSString *remoteID;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic) CMGender gender;

- (BOOL)isMale;
- (BOOL)isAdult;

@end

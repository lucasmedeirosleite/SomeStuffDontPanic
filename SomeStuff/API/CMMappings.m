//
//  CMMappings.m
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMMappings.h"
#import "CMPerson.h"

@implementation CMMappings

+ (EKObjectMapping *)personMapping
{
    return [EKObjectMapping mappingForClass:[CMPerson class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"name", @"age"]];
        [mapping mapKey:@"objectId" toField:@"remoteID"];
        [mapping mapKey:@"gender" toField:@"gender" withValueBlock:^id(NSString *key, id value) {
            NSDictionary *genders = @{ @"male" : @(CMGenderMale), @"female" : @(CMGenderFemale) };
            return genders[value];
        }];
    }];
}

@end

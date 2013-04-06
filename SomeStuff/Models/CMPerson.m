//
//  CMPerson.m
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMPerson.h"

@implementation CMPerson

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"remoteID" : @"remoteID",
              @"name" : @"name",
              @"age" : @"age",
              @"gender" : @"gender"
           };
}

+ (NSValueTransformer *)genderJSONTransformer
{
    NSDictionary *genders = @{
                             @"male": @(CMGenderMale),
                             @"female": @(CMGenderFemale)
                             };
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return genders[str];
    } reverseBlock:^(NSNumber *gender) {
        return [genders allKeysForObject:gender].lastObject;
    }];
}

- (BOOL)isMale
{
    return self.gender == CMGenderMale;
}

- (BOOL)isAdult
{
    return [self.age integerValue] >= 18;
}

@end

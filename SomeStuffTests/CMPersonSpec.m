//
//  CMPersonSpec.m
//  SomeStuff
//
//  Created by Lucas Medeiros on 05/04/13.
//  Copyright 2013 Codeminer42. All rights reserved.
//

#import "Kiwi.h"
#import "CMPerson.h"


SPEC_BEGIN(CMPersonSpec)

describe(@"CMPerson", ^{
   
    describe(@"#isMale", ^{
       
        __block CMPerson *person;
        
        beforeEach(^{
            person = [[CMPerson alloc] init];
        });
        
        context(@"when male", ^{
            
            beforeEach(^{
                person.gender = CMGenderMale;
            });
            
            it(@"should be true",  ^{
                [[theValue([person isMale]) should] beTrue];
            });
            
        });
        
        context(@"when female", ^{
            
            beforeEach(^{
                person.gender = CMGenderFemale;
            });
            
            specify(^{
                [[theValue([person isMale]) should] beFalse];
            });
            
        });
        
    });
    
    describe(@"#isAdult", ^{
        
        __block CMPerson *person;
        
        beforeEach(^{
            person = [[CMPerson alloc] init];
        });
        
        context(@"when person has more than or 18 years old", ^{
            
            beforeEach(^{
                person.age = @20;
            });
            
            it(@"should be true",  ^{
                [[theValue([person isAdult]) should] beTrue];
            });
            
        });
        
        context(@"when person has less than 18 years old", ^{
            
            beforeEach(^{
                person.age = @17;
            });
            
            specify(^{
                [[theValue([person isAdult]) should] beFalse];
            });
            
        });
        
    });
    
});

SPEC_END



//
//  CMAPIClientSpec.m
//  SomeStuff
//
//  Created by Lucas Medeiros on 05/04/13.
//  Copyright 2013 Codeminer42. All rights reserved.
//

#import "Kiwi.h"
#import "Nocilla.h"
#import "CMFixture.h"
#import "CMAppEnvironment.h"

#import "CMPerson.h"
#import "CMAPIClient.h"


SPEC_BEGIN(CMAPIClientSpec)

beforeAll(^{
    [[LSNocilla sharedInstance] start];
});
afterAll(^{
    [[LSNocilla sharedInstance] stop];
});
afterEach(^{
    [[LSNocilla sharedInstance] clearStubs];
});

describe(@"CMAPIClient", ^{
    
    describe(@"instance methods", ^{
       
        __block CMAPIClient *client;
        
        beforeEach(^{
            client = [CMAPIClient sharedInstance];
        });
        
        it(@"should respond to #peopleWithSuccessBlock:withErrorBlock", ^{
            [[client should] respondsToSelector:@selector(peopleWithSuccessBlock:withErrorBlock:)];
        });
        
    });

    describe(@"#peopleWithSuccessBlock:withErrorBlock:", ^{
    
        __block NSArray *people;
        __block NSError *error;
        
        beforeEach(^{
           
            NSString *peopleJSON = [CMFixture contentFromFixtureNamed:@"people" ofType:@"json"];
            NSString *url = [[CMAppEnvironment sharedInstance] apiURL];
            NSString *urlString = [NSString stringWithFormat:@"%@/people", url];
            
            stubRequest(@"GET", urlString).
            withHeaders(@{
                        @"X-Parse-Application-Id": [[CMAppEnvironment sharedInstance] parseAppID],
                        @"X-Parse-REST-API-Key": [[CMAppEnvironment sharedInstance] parseRestKey]
                        }).
            andReturn(200).
            withBody(peopleJSON);
            
            [[CMAPIClient sharedInstance] peopleWithSuccessBlock:^(NSArray *parsedPeople) {
                people = parsedPeople;
            } withErrorBlock:^(NSError *returnedError) {
                error = returnedError;
            }];
            
        });
        
        specify(^{
            [[expectFutureValue(people) shouldEventually] beNonNil];
        });
        
        specify(^{
            [[expectFutureValue(theValue([people count])) shouldEventually] equal:theValue(6)];
        });
        
        it(@"should have valid people", ^{
        
            [[expectFutureValue([[people objectAtIndex:0] name]) shouldEventually] equal:@"Person 1"];
            [[expectFutureValue([[people objectAtIndex:0] age]) shouldEventually] equal:theValue(25)];
            [[expectFutureValue(theValue([[people objectAtIndex:0] gender])) shouldEventually] equal:theValue(CMGenderMale)];
            
        });
        
    });
    
});

SPEC_END



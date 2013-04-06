//
//  CMPersonViewController.h
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPerson.h"

@interface CMPersonViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) CMPerson *person;
@property (nonatomic, weak) IBOutlet UITextField *personNameField;
@property (nonatomic, weak) IBOutlet UITextField *personAgeField;

@end

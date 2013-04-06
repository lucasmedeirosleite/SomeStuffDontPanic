//
//  CMPersonViewController.m
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMPersonViewController.h"
#import "SVProgressHUD.h"

@interface CMPersonViewController ()

@end

@implementation CMPersonViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.personNameField.text = self.person.name;
    self.personAgeField.text = [self.person.age description];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 12) {
        [[self.view viewWithTag:13] becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Private Actions

- (IBAction)updateTapped
{
    [self.view endEditing:YES];
    self.person.name = self.personNameField.text;
    self.person.age = [[NSNumber alloc]initWithInteger:[self.personAgeField.text integerValue]];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    if (!self.person._id || [self.person._id length] == 0) {
        [self savePerson];
    } else {
        [self updatePerson];
    }
}

- (void)savePerson
{
    [self.person createWithSuccessBlock:^{
        [SVProgressHUD dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:ReloadPeopleTableNotification object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"Person created" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } withErrorBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Something went wrong"];
    }];
}

- (void)updatePerson
{
    [self.person updateWithSuccessBlock:^{
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"Person updated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:ReloadPeopleTableNotification object:nil];
    } withErrorBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Something went wrong"];
    }];
}

@end

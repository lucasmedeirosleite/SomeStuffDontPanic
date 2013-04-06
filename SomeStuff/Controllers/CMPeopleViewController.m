//
//  CMPeopleViewController.m
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMPeopleViewController.h"
#import "CMPersonViewController.h"
#import "CMAPIClient.h"
#import "SVProgressHUD.h"
#import "CMPerson.h"

@interface CMPeopleViewController ()

@property (nonatomic, strong) NSArray *people;

@end

@implementation CMPeopleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPeopleTable:) name:ReloadPeopleTableNotification object:nil];
	[self loadPeople];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ReloadPeopleTableNotification object:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.people count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMPerson *person = [self.people objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell"];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [person.age description];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMPerson *person = [self.people objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"personSegue" sender:person];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"personSegue"]) {
        CMPersonViewController *controller = segue.destinationViewController;
        controller.person = sender;
    }
}

#pragma mark - Private methods

- (void)loadPeople
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[CMAPIClient sharedInstance] peopleWithSuccessBlock:^(NSArray *people) {
        self.people = people;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } withErrorBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Something went wrong"];
    }];
}

- (void)reloadPeopleTable:(NSNotification *)notification
{
    [self.tableView reloadData];
}

@end

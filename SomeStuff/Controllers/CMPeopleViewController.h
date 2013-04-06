//
//  CMPeopleViewController.h
//  SomeStuff
//
//  Created by Lucas Medeiros on 04/04/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMPeopleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

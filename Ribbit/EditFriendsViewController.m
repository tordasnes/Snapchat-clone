//
//  EditFriendsViewController.m
//  Ribbit
//
//  Created by Tord Åsnes on 04/11/13.
//  Copyright (c) 2013 Tord Åsnes. All rights reserved.
//

#import "EditFriendsViewController.h"
#import "MSCellAccessory.h"

@interface EditFriendsViewController ()

@end

@implementation EditFriendsViewController

UIColor *disclosureColor;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentUser = [PFUser currentUser];

    disclosureColor = [UIColor colorWithRed:0.553 green:0.439 blue:0.718 alpha:1.0];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Error: %@ %@", error, error.userInfo);
        } else {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.username;
    
    if ([self isFriend:user]) {
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:disclosureColor];

    } else {
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation *friendsRelation = [self.currentUser relationforKey:@"friendsRelation"];
    
    if ([self isFriend:user]) {
        // Remove friend
        
        for (PFUser *friend in self.friends) {
            cell.accessoryView = nil;

            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:friend];
                break;
            }
        }
        [friendsRelation removeObject:user];
    } else {
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:disclosureColor];
        [self.friends addObject:user];
        [friendsRelation addObject:user];
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, error.userInfo);
        }
    }];
    
    
}

#pragma mark - Helper methods

- (BOOL)isFriend:(PFUser *)user
{
    for (PFUser *friend in self.friends) {
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    return NO;
}


@end

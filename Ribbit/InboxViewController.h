//
//  InboxViewController.h
//  Ribbit
//
//  Created by Tord Åsnes on 03/11/13.
//  Copyright (c) 2013 Tord Åsnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
@interface InboxViewController : UITableViewController

@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) PFObject *selectedMessage;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

- (IBAction)logOut:(id)sender;

@end

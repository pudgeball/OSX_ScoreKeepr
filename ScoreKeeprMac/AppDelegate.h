//
//  AppDelegate.h
//  ScoreKeeprMac
//
//  Created by Nicholas McGuire on 2012-11-12.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Server.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, ServerDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *tableView;
@property (assign) IBOutlet NSTextField *txtMatchNumber;
@property (assign) IBOutlet NSTextField *lblMatchNumber;
@property (assign) IBOutlet NSTextField *lblAutonomousWinner;
@property (assign) IBOutlet NSTextField *lblRedScore;
@property (assign) IBOutlet NSTextField *lblBlueScore;


@property (strong, nonatomic) NSMutableArray *clients;
@property (strong, nonatomic) Server *server;

- (IBAction)sendStartMatch:(id)sender;

@end

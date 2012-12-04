//
//  AppDelegate.m
//  ScoreKeeprMac
//
//  Created by Nicholas McGuire on 2012-11-12.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import "AppDelegate.h"
#import "Match.h"
#import "Team.h"

@interface AppDelegate ()

@property (strong, nonatomic) Match *match;

- (void)handleMessageWithData:(NSData *)data;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_clients = [[NSMutableArray alloc] init];
	_server = [[Server alloc] initWithProtocol:@"Vex"];
	_server.delegate = self;
	
	NSError *error;
	if (![_server start:&error])
	{
		NSLog(@"Error starting server: %@", error);
		
	}
}

- (IBAction)sendWelcome:(id)sender
{
	
	NSLog(@"sending welcome");
	NSString *welcome = @"BeginMatch";
	
	NSData *data = [welcome dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	[_server sendData:data error:&error];
}

- (IBAction)sendStartMatch:(id)sender
{
	if ([_txtMatchNumber stringValue].length > 0)
	{
		NSString *matchNumber = [_txtMatchNumber stringValue];
		_match = [[Match alloc] initWithMatchNumber:matchNumber];
		
		[_lblMatchNumber setStringValue:[_match matchNumber]];
		
		NSLog(@"Beginning Match %@", matchNumber);
		
		NSDictionary *startMessage =  @{ @"Type" : @"Begin", @"MatchNumber" : _match.matchNumber };
		NSError *error = nil;
		NSData *messageData = [NSJSONSerialization dataWithJSONObject:startMessage options:NSJSONWritingPrettyPrinted error:&error];
		if (!error)
		{
			[_server sendData:messageData error:&error];
			if (error)
			{
				NSLog(@"Error Sending Begin Match Message Data");
			}
		}
		else
		{
			NSLog(@"Error creating JSON for message");
		}
	}
}

- (void)handleMessageWithData:(NSData *)data
{
	NSError *error = nil;
	
	NSDictionary *message = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
	if (!error)
	{
		if ([[message objectForKey:@"Type"] isEqualTo:@"Autonomous"])
		{
			NSLog(@"Autonomous Data: %@", message);
			
			NSString *winnerText = [NSString stringWithFormat:@"%@", [message objectForKey:@"Winner"]];
			NSLog(@"winnerText: %@", winnerText);
			[_lblAutonomousWinner setStringValue:winnerText];
			
			if ([[message objectForKey:@"Winner"] isEqualToString:@"red"])
			{
				_match.redTeam.autonomousWinner = YES;
				_match.blueTeam.autonomousWinner = NO;
			}
			else if ([[message objectForKey:@"Winner"] isEqualToString:@"blue"])
			{
				_match.redTeam.autonomousWinner = NO;
				_match.blueTeam.autonomousWinner = YES;
			}
			else if ([[message objectForKey:@"Winner"] isEqualToString:@"no"])
			{
				_match.redTeam.autonomousWinner = NO;
				_match.blueTeam.autonomousWinner = NO;
			}
		}
		else if ([[message objectForKey:@"Type"] isEqualToString:@"InGame"])
		{
			_match.redTeam.greenBallOver = [[message objectForKey:@"Red"] objectForKey:@"Score"];
			_match.blueTeam.greenBallOver = [[message objectForKey:@"Blue"] objectForKey:@"Score"];
		}
		else if ([[message objectForKey:@"Type"] isEqualToString:@"AfterGame"])
		{
			
		}
	}
	else
	{
		NSLog(@"Error decoding JSON message, handleMessageWithData");
	}
}

#pragma mark - ServerDelegate Methods

- (void)serverRemoteConnectionComplete:(Server *)server
{
    NSLog(@"Connected to service");
	
	[_clients addObject:server];
	
	[_tableView reloadData];
}

- (void)serverStopped:(Server *)server
{
    NSLog(@"Disconnected from service");
	
	[_tableView reloadData];
}

- (void)server:(Server *)server didNotStart:(NSDictionary *)errorDict
{
    NSLog(@"Server did not start %@", errorDict);
}

- (void)server:(Server *)server didAcceptData:(NSData *)data
{
    NSLog(@"Server did receive message");
	[self handleMessageWithData:data];
}

- (void)server:(Server *)server lostConnection:(NSDictionary *)errorDict
{
	NSLog(@"Lost connection");
	[_clients removeObject:server];
	[_tableView reloadData];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Added a service: %@", [service name]);
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Removed a service: %@", [service name]);
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [_clients count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	return [[_clients objectAtIndex:rowIndex] name];
}

@end

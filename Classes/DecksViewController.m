//
//  RootViewController.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright Me 2008. All rights reserved.
//

#import "DecksViewController.h"
#import "FlashMeAppDelegate.h"
#import "Deck.h"

@interface DecksViewController (Private)
- (FlashMeAppDelegate *)getAppDelegate;
@end

@implementation DecksViewController

- init {
	if (self = [super init]) {
		self.title = @"My Decks";
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// The accessory type is the image displayed on the far right of each table cell. In order for the delegate method
// tableView:accessoryButtonClickedForRowWithIndexPath: to be called, you must return the "Detail Disclosure Button" type.
- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDisclosureIndicator;
}

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"%s selected row: %i", _cmd, indexPath.row);
	
	Deck *deck = [[self getAppDelegate] getDeckAtIndex:indexPath.row];
	[[self getAppDelegate] activateDeck:deck];
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self getAppDelegate] countOfDecks];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
	}

	// Set up the cell
	Deck *deck = [[Deck readAllDecks] objectAtIndex:indexPath.row];
	NSLog(@"%s deck.title at get cell: %@", _cmd, [deck getTitle]);
	cell.text = [deck getTitle];
	return cell;
}

- (void)dealloc {
	[super dealloc];
}

- (void)loadView {
	[super loadView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (FlashMeAppDelegate *)getAppDelegate {
	return (FlashMeAppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end

//
//  DeckViewController.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright 2008 Me. All rights reserved.
//

#import "FlashMeAppDelegate.h"
#import "DeckViewController.h"
#import "MultilineTableCell.h"
#import "CardViewController.h"

@interface DeckViewController (Private)
- (FlashMeAppDelegate *)getAppDelegate;
@end

@implementation DeckViewController

- (id)initWithDeck:(Deck *)aDeck
{
	if (self = [super init]) {
		// Initialize your view controller.
		self.title = @"DeckViewController";
		deckTableModel = [[DeckTableModel alloc] initWithDeck:aDeck];
	}
	return self;
}

- (void)setDeck:(Deck *)aDeck {
  NSLog(@"%s DeckViewController#setDeck:%@", _cmd, aDeck);
	deck = aDeck;
	self.title = [deck getTitle];
}

- (void)loadView
{	
	deckView = [[[DeckView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] 
		model:deckTableModel] autorelease];
  self.view = deckView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"MyIdentifier"];
	if (cell == nil) {
			// Create a new cell. CGRectZero allows the cell to determine the appropriate size.
			cell = [[[UISimpleTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
  	}

		Card *card = [deck getCardAtIndex:indexPath.row];
		cell.text = card.title;
  	return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"%s card in row: %i", _cmd, indexPath.row);
	Card *card = [deck getCardAtIndex:indexPath.row];
	if (cardViewController == nil) {
		cardViewController = [[[CardViewController alloc] init] autorelease];
	}
	
	[cardViewController setCard:card];
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.75];
//		
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
//										forView:containerView cache:YES];
//	
	// Getting two in a row here. If we're already hidden then we're good.
//	if (![self navigationController].navigationBar.hidden) {
//		[tableView removeFromSuperview];
//		[containerView addSubview:cardViewController.view];
		[self.navigationController pushViewController:cardViewController animated:YES];  
		[self navigationController].navigationBar.hidden = YES;
//	}
//	[UIView commitAnimations];
	return nil;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview.
	// Release anything that's not essential, such as cached data.
}

- (void)dealloc {
	[super dealloc];
}

- (FlashMeAppDelegate *)getAppDelegate {
	return (FlashMeAppDelegate *)[[UIApplication sharedApplication] delegate];
}
@end

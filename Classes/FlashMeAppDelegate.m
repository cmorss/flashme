//
//  iFlashMeAppDelegate.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright Me 2008. All rights reserved.
//

#import "FlashMeAppDelegate.h"
#import "DecksViewController.h"
#import "Deck.h"
#import "Database.h"

@interface FlashMeAppDelegate ()
@property (nonatomic, copy, readwrite) NSArray *decks;
@end

@implementation FlashMeAppDelegate

@synthesize window;
@synthesize decks;

- init {
	if (self = [super init]) {
		// Initialization code
	}
	return self;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	[Database remigrate];

	self.decks = [Deck readAllDecks];
	[self.decks retain];
	
	// Create the navigation and view controllers
	decksViewController = [[DecksViewController alloc] init];
	deckViewController = [[DeckViewController alloc] init];

	// Configure and show the window
	[window addSubview:[decksViewController view]];
	[window makeKeyAndVisible];
}

- (void)activateDeck:(Deck *)aDeck {
	[aDeck loadCards];
	[deckViewController setDeck:aDeck];
	[decksViewController.view removeFromSuperview];
	[window addSubview:deckViewController.view];
}

- (void)activateCard:(Card *)aCard {
	[cardViewController setCard:aCard];
	[deckViewController.view removeFromSuperview];
	[window addSubview:cardViewController.view];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)setDecks:(NSArray *)newList {
	if (decks != newList) {
		[decks release];
		decks = [newList mutableCopy];
	}
}

- (NSUInteger)countOfDecks {
	return [decks count];
}

- (id)getDeckAtIndex:(NSUInteger)theIndex {
	return [decks objectAtIndex:theIndex];
}

- (void)getDecks:(id *)objsPtr range:(NSRange)range {
	[decks getObjects:objsPtr range:range];
}

- (void)insertDeck:(id)obj inDecksAtIndex:(NSUInteger)theIndex {
	[decks insertObject:obj atIndex:theIndex];
}

- (void)dealloc {
	[decksViewController release];
	[deckViewController release];
  [window release];
	[decks release];
  [super dealloc];
}

@end

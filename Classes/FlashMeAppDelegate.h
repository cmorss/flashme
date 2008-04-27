//
//  iFlashMeAppDelegate.h
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright Me 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DecksViewController.h"
#import "DeckViewController.h"
#import "CardViewController.h"

@interface FlashMeAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	DecksViewController *decksViewController;
	DeckViewController *deckViewController;
	CardViewController *cardViewController;

	NSMutableArray *decks;
}

@property (nonatomic, retain) UIWindow *window;

@property (nonatomic, copy, readonly) NSArray *decks;

- (NSUInteger)countOfDecks;
- (id)getDeckAtIndex:(NSUInteger)theIndex;
- (void)getDecks:(id *)objsPtr range:(NSRange)range;
- (void)insertDeck:(id)obj inDecksAtIndex:(NSUInteger)theIndex;

- (void)activateDeck:(Deck *)aDeck;
- (void)activateCard:(Card *)aCard;

@end


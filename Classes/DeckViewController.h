//
//  DeckViewController.h
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright 2008 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardViewController.h"
#import "DeckView.h"

@interface DeckViewController : UIViewController <UITableViewDelegate> {
	DeckTableModel *deckTableModel;
	DeckView *deckView;;
}

- (void)setDeck:(Deck *)aDeck;

@end

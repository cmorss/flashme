//
//  DeckTableModel.h
//  iFlashMe
//
//  Created by Charlie Morss on 4/26/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface DeckTableModel : NSObject <UITableViewDataSource> {
	Deck *deck;
}

- (id)initWithDeck:(Deck *)aDeck;

- (Deck *)getDeck;
- (void)setDeck:(Deck *)aDeck;

@end

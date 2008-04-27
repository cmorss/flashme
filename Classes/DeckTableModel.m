//
//  DeckTableModel.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/26/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import "DeckTableModel.h"

@implementation DeckTableModel

#pragma mark UITableViewDelegate Methods

- (id)initWithDeck:(Deck *)aDeck {
	if (self = [super init]) {
		deck = aDeck;
	}
	return self;
}

- (Deck *)getDeck {
	return deck;
}

- (void)setDeck:(Deck *)aDeck {
	deck = aDeck;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
  NSLog(@"%s get rows: %i", _cmd, [[deck getCards] count]);
	return [[deck getCards] count];
}
		
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
    	case 0: return @"";
    	case 1: return @"Cards";
    }
    return nil;
}

@end

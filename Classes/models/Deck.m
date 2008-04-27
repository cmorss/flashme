//
//  Deck.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright 2008 Me. All rights reserved.
//
#import "Deck.h"
#import "Card.h"
#import "Database.h"

static NSMutableArray *decks;

@implementation Deck

+ (NSArray *)readAllDecks {

	if (decks != nil) {
		return decks;
	}
	
	decks = [[NSMutableArray alloc] init];

	Statement *statement = [Database prepareStatement:@"SELECT primary_key, title, description FROM decks;"];
		
	if (![statement inError]) {
	
	
	
		while ([statement nextRow]) {	
			int pk = [statement intAtColumn:0];
			NSString *t = [statement textAtColumn:1];
			NSString *d = [statement textAtColumn:2];

			Deck *deck = [[Deck alloc] initWithPrimaryKey:pk title:t description:d];
		  NSLog(@"%s key: %i", _cmd, pk);
		  NSLog(@"%s title: %@", _cmd, t);
		  NSLog(@"%s title from deck: %@", _cmd, [deck getTitle]);
		  NSLog(@"%s description from deck: %@", _cmd, [deck getDescription]);
			
			[decks addObject:deck];
			[deck release];
		}
	}
	else {
	  NSLog(@"Failed to read decks: %i, '%@'", [statement status], [statement errorMessage]);
		NSAssert1(0, @"Failed to read decks: '%@'", [statement status]);
	}
	[statement finalize];

  return decks;
}

- (id)initWithPrimaryKey:(NSInteger)pk title:(NSString *)aTitle description:(NSString *)aDescription {
  if (self = [super init]) {
		primaryKey = pk;
    title = aTitle;
		description = aDescription;
  }
  return self;
}

- (void)addCard:(Card *)aCard {
	[cards addObject:aCard];
}

- (NSString *)getTitle {
	return [title copy];
}

- (NSString *)getDescription {
	return [description copy];
}

- (NSArray *)getCards {
	if (cards == nil) {
		[self loadCards];
	}
	return cards;
}

- (Card *)getCardAtIndex:(int)aIndex {
	return [cards objectAtIndex:aIndex];
}

- (void)loadCards {
	if (cards != nil) {
		return;
	}

  cards = [[NSMutableArray alloc] init];

	Statement *statement = [Database 
		prepareStatement:@"SELECT question, answer, title FROM cards where deck_id = ? order by position;"];
		
	if (![statement inError]) {
	  [statement bindInt:primaryKey forPosition:1];
		
		while ([statement nextRow]) {	
			NSString *q = [statement textAtColumn:0];
			NSString *a = [statement textAtColumn:1];
			NSString *t = [statement textAtColumn:2];

			Card *card = [[Card alloc] initWithTitle:t question:q answer:a];
			[self addCard:card];
		}
	}
	else {
		NSAssert1(0, @"Failed to read decks: '%s'", [statement errorMessage]);
	}
	[statement finalize];
}

@end

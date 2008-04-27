//
//  Deck.h
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright 2008 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface Deck : NSObject {
	NSString *title;
	NSString *description;
	int primaryKey;
	NSMutableArray *cards;
}


+ (NSArray *)readAllDecks;

- (id)initWithPrimaryKey:(NSInteger)pk title:(NSString *)aTitle description:(NSString*)aDescription;
- (void)addCard:(Card *)aCard;
- (Card *)getCardAtIndex:(int)aIndex;
- (NSString *)getTitle;
- (NSString *)getDescription;
- (void)loadCards;
- (NSArray *)getCards;
@end

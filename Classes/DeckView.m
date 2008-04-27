//
//  DeckView.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/26/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import "DeckView.h"


@implementation DeckView

- (id)initWithFrame:(CGRect)frame model:(DeckTableModel *)aModel {
	if (self = [super initWithFrame:frame]) {
		// Create the main table.
		tableView = [[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain] autorelease];
		tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
		tableView.delegate = aModel;
		tableView.dataSource = aModel; 	
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect {
	// Drawing code
}

- (void)dealloc {
	[super dealloc];
}

@end

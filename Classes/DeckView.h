//
//  DeckView.h
//  iFlashMe
//
//  Created by Charlie Morss on 4/26/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeckTableModel.h"

@interface DeckView : UIView {
	UITableView *tableView;
}

- (id)initWithFrame:(CGRect)frame model:(DeckTableModel *)aModel;


@end

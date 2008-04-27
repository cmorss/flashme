//
//  FlashViewController.h
//  iFlashMe
//
//  Created by Charlie Morss on 4/24/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardViewController : UIViewController <UIWebViewDelegate> {
	UILabel *descriptionLabel;
	Card *card;
	UIWebView *webView;
}

- (void)setCard:(Card *)aCard;
@end

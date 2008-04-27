//
//  FlashViewController.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/24/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import "CardViewController.h"

@implementation CardViewController

- (void)setCard:(Card *)aCard {
	card = aCard;
}

- (void)loadView {

	// the base view for this view controller
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor whiteColor];
	
	// important for view orientation rotation
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);	
	self.view = contentView;
	self.view.autoresizesSubviews = YES;
	
	[contentView release];
	
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
	webFrame.origin.y += 5.0 + 5.0;	// leave from the URL input field and its label
	webFrame.size.height -= 40.0;
	webView = [[UIWebView alloc] initWithFrame:webFrame];
	webView.backgroundColor = [UIColor redColor];
	webView.scalesPageToFit = YES;
	webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	webView.delegate = self;
	[self.view addSubview: webView];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.digg.com"]]];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
//					duration:(NSTimeInterval)duration {	
//	if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
//		[[self navigationController] popViewControllerAnimated:NO];
//		[self navigationController].navigationBar.hidden = NO;
//	}
//}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}

@end

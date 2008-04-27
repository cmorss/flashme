//
//  untitled.h
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Card : NSObject {
  int      position;
	NSString *title;
	NSString *question;
	NSString *answer;
}

@property (readonly, copy) NSString *question, *answer, *title;
@property (readonly) int position;

- (id)initWithTitle:(NSString *)title question:(NSString *)question answer:(NSString *)answer;

@end

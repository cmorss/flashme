//
//  untitled.m
//  iFlashMe
//
//  Created by Charlie Morss on 4/21/08.
//  Copyright 2008 AdReady. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize title, question, answer, position;

- (id)initWithTitle:(NSString *)aTitle question:(NSString *)aQuestion answer:(NSString *)anAnswer {
  if (self = [super init]) {
		question = [aQuestion copy];
		answer = [anAnswer copy];
		title = [aTitle copy];
  }
  return self;
}


@end

//
//  BCStatusItem.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "BCStatusItem.h"
#import "BCStatusItemView.h"

@implementation NSStatusItem(BCStatusItemAdditions)

- (void)setupView
{
	BCStatusItemView *view = [[BCStatusItemView viewWithStatusItem:self] retain]; // we should hold on to a reference possibly
	//[mStatusItemView setDelegate:self];
	//[view setStatusMenu:mMenuExtraMenu];
	[self setView:view];
	[[self menu] setDelegate:view];
}

- (void)setAllowsDragging:(BOOL)dragging
{
	
}

- (void)setDraggingTypes:(NSArray *)types
{
	
}

- (NSArray *)draggingTypes
{
	return nil;
}

- (NSRect)frame
{
	return NSZeroRect;
}

@end

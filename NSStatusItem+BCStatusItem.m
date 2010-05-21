//
//  NSStatusItem+BCStatusItem.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "NSStatusItem+BCStatusItem.h"
#import "BCStatusItemView.h"

@implementation NSStatusItem(BCStatusItem)

- (void)setupView
{
	BCStatusItemView *view = [BCStatusItemView viewWithStatusItem:self];
	// grab the statu item's various vars that get cleared upon setView:
	[view setImage:[self image]];
	[view setAlternateImage:[self alternateImage]];
	[view setAttributedTitle:[self attributedTitle]];
	[view setDoesHighlight:[self highlightMode]];
	
	[self setView:view];
	
	// view becomes delegate for highlighting purposes, this isn't ideal for all cases
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
	return [[[self view] window] frame];
}

- (void)setViewDelegate:(id)delegate
{
	if([[self view] respondsToSelector:@selector(setDelegate:)])
		[(BCStatusItemView *)[self view] setDelegate:delegate];
}

@end

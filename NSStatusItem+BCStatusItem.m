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
	[view setImage:[self image]];
	[view setAlternateImage:[self alternateImage]];
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
	return [[[self view] window] frame];
}

- (void)setViewDelegate:(id)delegate
{
	if([[self view] respondsToSelector:@selector(setDelegate:)])
		[(BCStatusItemView *)[self view] setDelegate:delegate];
}

@end

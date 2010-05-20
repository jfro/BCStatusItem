//
//  BCStatusItemView.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "BCStatusItemView.h"


@implementation BCStatusItemView

+ (BCStatusItemView *)viewWithStatusItem:(NSStatusItem *)statusItem
{
	return [[[BCStatusItemView alloc] initWithStatusItem:statusItem] autorelease];
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
	NSRect frame = NSMakeRect(0, 0, [statusItem length], [[NSStatusBar systemStatusBar] thickness]);
	if((self = [self initWithFrame:frame]))
	{
		mParentStatusItem = statusItem;
	}
	return self;
}

- (void)setDelegate:(id)newDelegate
{
	delegate = newDelegate;
}

- (id)delegate
{
	return delegate;
}

- (void)setImage:(NSImage *)image
{
	[image retain];
	[mImage release];
	mImage = image;
}

- (NSImage *)image
{
	return mImage;
}

- (void)setAlternateImage:(NSImage *)image
{
	[image retain];
	[mAlternateImage release];
	mAlternateImage = image;
}

- (NSImage *)alternateImage
{
	return mAlternateImage;
}

#pragma mark -

- (void)mouseDown:(NSEvent *)theEvent
{
	[mParentStatusItem popUpStatusItemMenu:[mParentStatusItem menu]];
}

#pragma mark -
#pragma mark NSMenu Delegate

- (void)menuWillOpen:(NSMenu *)menu
{
	mHighlighted = YES;
	[self setNeedsDisplay:YES];
}

- (void)menuDidClose:(NSMenu *)menu
{
	mHighlighted = NO;
	[self setNeedsDisplay:YES];	
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect {
	NSImage *image = nil;
	if(mHighlighted)
	{
		[[NSColor selectedMenuItemColor] set];
		[NSBezierPath fillRect:[self bounds]];
		image = mAlternateImage;
	}
	else
		image = mImage;
	
	NSRect centeredRect = NSMakeRect(0, 0, [image size].width, [image size].height);
	centeredRect.origin.x = NSMidX([self bounds]) - ([image size].width / 2);
	centeredRect.origin.y = NSMidY([self bounds]) - ([image size].height / 2);
	[image drawInRect:centeredRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

#pragma mark -
#pragma mark NSDraggingDestination protocol

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	return [delegate statusItemView:self draggingEntered:sender];
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	[delegate statusItemView:self draggingExited:sender];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{	
	return [delegate statusItemView:self prepareForDragOperation:sender];
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	return [delegate statusItemView:self performDragOperation:sender];
}

@end

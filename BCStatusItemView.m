//
//  BCStatusItemView.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "BCStatusItemView.h"

@interface BCStatusItemView(Private)
- (void)_resizeToFitIfNeeded;
@end

@implementation BCStatusItemView

@synthesize doesHighlight=mDoesHighlight;
@synthesize title=mTitle;
@synthesize attributedTitle=mAttributedTitle;
@synthesize image=mImage;
@synthesize alternateImage=mAlternateImage;
@synthesize delegate;

+ (BCStatusItemView *)viewWithStatusItem:(NSStatusItem *)statusItem
{
	return [[[BCStatusItemView alloc] initWithStatusItem:statusItem] autorelease];
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat length = ([statusItem length] == NSVariableStatusItemLength) ? 32.0f : [statusItem length];
	NSRect frame = NSMakeRect(0, 0, length, [[NSStatusBar systemStatusBar] thickness]);
	if((self = [self initWithFrame:frame]))
	{
		mParentStatusItem = statusItem;
		[mParentStatusItem addObserver:self forKeyPath:@"length" options:NSKeyValueObservingOptionNew context:nil];
		self.title = nil;
		self.attributedTitle = nil;
		self.doesHighlight = NO;
		self.image = nil;
		self.alternateImage = nil;
		self.delegate = nil;
	}
	return self;
}

- (void)dealloc
{
	[mParentStatusItem removeObserver:self forKeyPath:@"length"];
	self.title = nil;
	self.attributedTitle = nil;
	self.image = nil;
	self.alternateImage = nil;
	self.delegate = nil;
	mParentStatusItem = nil; // we only had weak reference
	[super dealloc];
}

- (void)_resizeToFitIfNeeded
{
    if([mParentStatusItem length] == NSVariableStatusItemLength)
    {
        NSRect newFrame = [self frame];
        newFrame.size.width = [[self image] size].width + 8; // 12 px padding, 6 on each side maybe? not sure what might be the usual
        [self setFrame:newFrame];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if(object == mParentStatusItem && [keyPath isEqualToString:@"length"])
	{
		if([mParentStatusItem length] != NSVariableStatusItemLength)
		{
			NSRect newFrame = [self frame];
			newFrame.size.width = [mParentStatusItem length];
			[self setFrame:newFrame];
		}
		else
			[self _resizeToFitIfNeeded];
	}
}

#pragma mark -

- (void)setImage:(NSImage *)newImage
{
	if(newImage != mImage)
	{
		[mImage release];
		mImage = [newImage copy];
        [self _resizeToFitIfNeeded];
		[self setNeedsDisplay:YES];
	}
}

- (void)setAlternateImage:(NSImage *)newAltImage
{
	if(newAltImage != mAlternateImage)
	{
		[mAlternateImage release];
		mAlternateImage = [newAltImage copy];
		[self setNeedsDisplay:YES];
	}
}

- (void)setTitle:(NSString *)newTitle
{
	if(newTitle != mTitle)
	{
		[mTitle release];
		mTitle = [newTitle copy];
		[self setNeedsDisplay:YES];
	}
}

- (void)setAttributedTitle:(NSAttributedString *)newTitle
{
	if(newTitle != mAttributedTitle)
	{
		[mAttributedTitle release];
		mAttributedTitle = [newTitle copy];
		[self setNeedsDisplay:YES];
	}
}

// TODO: setAttributedTitle with default attribtues
//- (void)setTitle:(NSString *)title
//{
//	NSFont *font = [NSFont menuBarFontOfSize:[NSFont systemFontSize] + 2.0f];
//	NSColor *color = [NSColor controlTextColor];
//
//	if(mHighlighted && [self doesHighlight])
//	{
//		color = [NSColor selectedMenuItemTextColor];
//	}
//
//	NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
//						   font, NSFontAttributeName,
//						   color, NSForegroundColorAttributeName,
//						   nil];
//}

#pragma mark -

- (void)mouseDown:(NSEvent *)theEvent
{
	// TODO: implement other behaviors like support for target/action & doubleAction
    mHighlighted = YES;
    [self setNeedsDisplay:YES];
	[mParentStatusItem popUpStatusItemMenu:[mParentStatusItem menu]];
    // apparently the above blocks?
    mHighlighted = NO;
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    mHighlighted = NO;
    [self setNeedsDisplay:YES];
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

- (void)drawRect:(NSRect)dirtyRect
{
	// TODO: handle image + title, centering the combined rect with image on left
	NSImage *drawnImage = nil;
	if(mHighlighted && [self doesHighlight])
	{
		[[NSColor selectedMenuItemColor] set];
		[NSBezierPath fillRect:[self bounds]];
		drawnImage = self.alternateImage;
	}
	else
		drawnImage = self.image;
	
	NSRect centeredRect = NSMakeRect(0, 0, [drawnImage size].width, [drawnImage size].height);
	centeredRect.origin.x = NSMidX([self bounds]) - ([drawnImage size].width / 2);
	centeredRect.origin.y = NSMidY([self bounds]) - ([drawnImage size].height / 2);
	centeredRect = NSIntegralRect(centeredRect);
	[drawnImage drawInRect:centeredRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	if(self.attributedTitle)
	{
		[self.attributedTitle drawInRect:[self bounds]];
	}
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

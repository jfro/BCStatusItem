//
//  BCStatusItemAppDelegate.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "BCStatusItemAppDelegate.h"
#import "NSStatusItem+BCStatusItem.h"
#import "BCStatusItemView.h"

@implementation BCStatusItemAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSImage *image = [NSImage imageNamed:@"status"];
	NSImage *alternateImage = [NSImage imageNamed:@"status-selected"];
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:[image size].width+40] retain];
	[statusItem setMenu:statusMenu];
	[statusItem setImage:image];
	[statusItem setAlternateImage:alternateImage];
	[statusItem setHighlightMode:YES];
	
	[statusItem setTitle:@"Test"];

	[statusItem setupView];
	
	[statusItem setViewDelegate:self];
	[[statusItem view] registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

- (NSDragOperation)statusItemView:(BCStatusItemView *)view draggingEntered:(id <NSDraggingInfo>)info
{
	NSLog(@"Drag entered!");
	return NSDragOperationCopy;
}

- (void)statusItemView:(BCStatusItemView *)view draggingExited:(id <NSDraggingInfo>)info
{
	NSLog(@"Dragging exit");
}

- (BOOL)statusItemView:(BCStatusItemView *)view prepareForDragOperation:(id <NSDraggingInfo>)info
{
	NSLog(@"Prepare for drag");
	return YES;
}

- (BOOL)statusItemView:(BCStatusItemView *)view performDragOperation:(id <NSDraggingInfo>)info
{
	NSLog(@"Perform drag");
	return YES;
}

@end

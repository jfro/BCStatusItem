//
//  BCStatusItemAppDelegate.m
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import "BCStatusItemAppDelegate.h"
#import "BCStatusItem.h"

@implementation BCStatusItemAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSImage *image = nil;
	NSImage *alternateImage = nil;
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:[image size].width+10] retain];
	[statusItem setMenu:statusMenu];
	[statusItem setImage:image];
	[statusItem setAlternateImage:alternateImage];
	[statusItem setHighlightMode:YES];
	
	[statusItem setupView];
	
	// Insert code here to initialize your application 
	/*
	mMenuExtra = [[[NSStatusBar systemStatusBar] statusItemWithLength:[icon size].width+10] retain];
	[mMenuExtra setMenu:mMenuExtraMenu];
	[mMenuExtra setImage:icon];
	[mMenuExtra setAlternateImage:hilightedIcon];
	[mMenuExtra setHighlightMode:YES];
	if([self leopardOrBetter] && [[NSUserDefaults standardUserDefaults] boolForKey:@"DragsterWithBacon"])
	{
		mStatusItemView = [[ASWStatusItemDropView viewWithStatusItem:mMenuExtra] retain]; // we should hold on to a reference possibly
		[mStatusItemView setDelegate:self];
		[mStatusItemView setStatusMenu:mMenuExtraMenu];
	}
	*/
}

@end

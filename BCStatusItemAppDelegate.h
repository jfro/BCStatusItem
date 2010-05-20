//
//  BCStatusItemAppDelegate.h
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BCStatusItemAppDelegate : NSObject
{
    NSWindow *window;
	NSStatusItem *statusItem;
	IBOutlet NSMenu *statusMenu;
}

@property (assign) IBOutlet NSWindow *window;

@end

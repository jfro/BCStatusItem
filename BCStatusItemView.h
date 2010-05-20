//
//  BCStatusItemView.h
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BCStatusItemView;

@protocol BCStatusItemViewDelegate
- (NSDragOperation)statusItemView:(BCStatusItemView *)view draggingEntered:(id <NSDraggingInfo>)info;
- (void)statusItemView:(BCStatusItemView *)view draggingExited:(id <NSDraggingInfo>)info;
- (BOOL)statusItemView:(BCStatusItemView *)view prepareForDragOperation:(id <NSDraggingInfo>)info;
- (BOOL)statusItemView:(BCStatusItemView *)view performDragOperation:(id <NSDraggingInfo>)info;
@end

@interface BCStatusItemView : NSView
{
	NSStatusItem *mParentStatusItem;
	NSMenu *mMenu;
	
	BOOL mHighlighted;
	
	NSImage *mImage;
	NSImage *mAlternateImage;
	
	id<BCStatusItemViewDelegate> delegate;
}

+ (BCStatusItemView *)viewWithStatusItem:(NSStatusItem *)statusItem;
- (id)initWithStatusItem:(NSStatusItem *)statusItem;

- (void)setImage:(NSImage *)image;
- (NSImage *)image;

- (void)setAlternateImage:(NSImage *)image;
- (NSImage *)alternateImage;

- (void)setDelegate:(id)newDelegate;
- (id)delegate;

//- (void)registerForDraggedTypes:(NSArray *)types;

@end

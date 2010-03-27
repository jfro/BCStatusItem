//
//  BCStatusItem.h
//  BCStatusItem
//
//  Created by Jeremy Knope on 3/22/10.
//  Copyright 2010 Buttered Cat Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSStatusItem(BCStatusItemAdditions)

- (void)setupView;

- (void)setAllowsDragging:(BOOL)dragging;
- (void)setDraggingTypes:(NSArray *)types;
- (NSArray *)draggingTypes;

- (NSRect)frame;

@end

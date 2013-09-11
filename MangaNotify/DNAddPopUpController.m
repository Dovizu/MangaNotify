//
//  DNAddPopUpController.m
//  MangaNotify
//
//  Created by Donny Reynolds on 5/3/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import "DNAddPopUpController.h"
#import "DNMangaNotifyModel.h"
#import "DNPreViewWinController.h"

@interface DNAddPopUpController ()

@end

@implementation DNAddPopUpController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}


- (IBAction)submit:(id)sender{
    
    NSString *title = [titleField stringValue];
    NSString *alias = [aliasField stringValue];
    BOOL result = [self.model addMangaWithTitle:title andAlias:alias];
    
    if (result){
        [self.window close];
    }else{
        [notFoundLabel setStringValue:@"Cannot find this alias"];
    }
}

- (IBAction)cancel:(id)sender
{
    [self.window close];
}

- (IBAction)helpButtonPressed:(id)sender
{
    [self.popover showRelativeToRect:[sender bounds]
                              ofView:sender
                       preferredEdge:NSMaxXEdge];
}

- (void)windowWillClose:(NSNotification *)notification
{    
    [self.prefViewController forceRefreshButtonClicked:nil];
    [NSApp stopModal];
}


- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor
{
    if ([self.popover isShown]){
        [self.popover close];
    }
    return YES;
}

@end

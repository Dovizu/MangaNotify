//
//  DNAppDelegate.m
//  MangaNotify
//
//  Created by Donny Reynolds on 5/2/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import "DNAppDelegate.h"
#import "DNPreViewWinController.h"
#import "DNMangaNotifyModel.h"



@implementation DNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    model = [[DNMangaNotifyModel alloc] init];
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:model];
    timer = [NSTimer scheduledTimerWithTimeInterval:1800.0 target:model selector:@selector(backGroundRefresh:) userInfo:nil repeats:YES];
}


- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];

    [statusItem setImage:[NSImage imageNamed:@"menuIcon"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"menuIconInvert"]];

    [statusItem setHighlightMode:YES];
}

- (IBAction)mangaList:(id)sender {
    if (!prefView) {
        prefView = [[DNPreViewWinController alloc] initWithWindowNibName:@"prefView" andModel:model];
    }
    [prefView showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    
}

- (IBAction)refresh:(id)sender {
    [prefView forceRefreshButtonClicked:nil];
}

- (IBAction)quit:(id)sender {
    [NSApp terminate:self];
}



@end

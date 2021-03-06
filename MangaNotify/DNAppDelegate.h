//
//  DNAppDelegate.h
//  MangaNotify
//
//  Created by Donny Reynolds on 5/2/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DNPreViewWinController, DNMangaNotifyModel;


@interface DNAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    DNPreViewWinController *prefView;
    DNMangaNotifyModel *model;
    NSTimer *timer;
}

@end

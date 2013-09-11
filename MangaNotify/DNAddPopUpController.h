//
//  DNAddPopUpController.h
//  MangaNotify
//
//  Created by Donny Reynolds on 5/3/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DNMangaNotifyModel, DNMangaNotifyModel, DNPreViewWinController;



@interface DNAddPopUpController : NSWindowController <NSTextFieldDelegate, NSWindowDelegate, NSTextFieldDelegate> {

    IBOutlet NSTextField *titleField;
    IBOutlet NSTextField *aliasField;
    IBOutlet NSTextField *notFoundLabel;
    
}

@property (assign) DNMangaNotifyModel *model;
@property (assign) DNPreViewWinController *prefViewController;
@property (assign) IBOutlet NSPopover *popover;

- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;



@end

//
//  DNPreViewWinController.h
//  MangaNotify
//
//  Created by Donny Reynolds on 5/3/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DNMangaNotifyModel, DNAddPopUpController;


@interface DNPreViewWinController : NSWindowController <NSTableViewDataSource>{

    IBOutlet NSTableView *displayTable;
    DNAddPopUpController *popUpControl;
}

@property (assign) DNMangaNotifyModel *model;

- (id)initWithWindowNibName:(NSString *)windowNibName andModel: (DNMangaNotifyModel*)model;
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)removeButtonClicked:(id)sender;
- (IBAction)forceRefreshButtonClicked:(id)sender;
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;

@end

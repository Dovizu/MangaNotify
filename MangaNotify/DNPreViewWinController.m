//
//  DNPreViewWinController.m
//  MangaNotify
//
//  Created by Donny Reynolds on 5/3/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import "DNPreViewWinController.h"
#import "DNAddPopUpController.h"
#import "DNMangaNotifyModel.h"


@interface DNPreViewWinController ()

@end

@implementation DNPreViewWinController

- (id)initWithWindowNibName:(NSString *)windowNibName andModel: (DNMangaNotifyModel*)model
{
    self = [super initWithWindowNibName:windowNibName];
    if (self){
        self.model = model;
        [displayTable setDataSource:self];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}


- (IBAction)addButtonClicked:(id)sender{
//    NSLog(@"addButtonClicked: is called from prefViewController");
    popUpControl = [[DNAddPopUpController alloc] initWithWindowNibName:@"popUp"];
    popUpControl.model = self.model;
    popUpControl.prefViewController = self;
    [NSApp runModalForWindow: [popUpControl window]];
}


- (IBAction)removeButtonClicked:(id)sender{
//    NSLog(@"remove button clicked from prefViewController");

    NSString *title = [[self.model listOfManga] objectAtIndex:[displayTable selectedRow]];
    [self.model removeMangaWithTitle: title];
    [self forceRefreshButtonClicked:nil];
}


- (IBAction)forceRefreshButtonClicked:(id)sender{
//    NSLog(@"refresh button clicked from prefViewController");
    [displayTable reloadData];
    [self.model fetchUpdates];
}




- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
//    NSLog(@"numOfRowsInTableView called from prefViewController");
    return [[self.model listOfManga] count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex{
//    NSLog(@"row fetch called from prefViewController");
    return [[self.model listOfManga] objectAtIndex:rowIndex];
}





@end

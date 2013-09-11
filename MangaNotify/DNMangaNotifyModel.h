//
//  DNMangaNotifyModel.h
//  MangaNotify
//
//  Created by Donny Reynolds on 5/2/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNMangaNotifyModel : NSObject <NSUserNotificationCenterDelegate> {
    
    NSUserDefaults *userDefaults;
    NSMutableDictionary *titleToID;
    NSMutableDictionary *idToChapter;
    NSString *extractTitleToID;
    NSString *extractIDtoChapter;
    NSArray *libArray;
}

- (BOOL) addMangaWithTitle:(NSString*)title andAlias: (NSString*)alias;
- (void) removeMangaWithTitle:(NSString*)Key;
- (NSArray*) listOfManga;
- (void)fetchUpdates;



@end

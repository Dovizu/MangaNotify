//
//  DNMangaNotifyModel.m
//  MangaNotify
//
//  Created by Donny Reynolds on 5/2/13.
//  Copyright (c) 2013 Dovizu Network. All rights reserved.
//

#import "DNMangaNotifyModel.h"

@implementation DNMangaNotifyModel

- (id) init {
    self = [super init];
    if (self){
        extractTitleToID = @"extractTitleToID";
        extractIDtoChapter = @"extractIDtoChapter";
        userDefaults = [NSUserDefaults standardUserDefaults];
        
        if ([userDefaults objectForKey:extractTitleToID]){
            titleToID = [[userDefaults objectForKey:extractTitleToID] mutableCopy];
            idToChapter = [[userDefaults objectForKey:extractIDtoChapter] mutableCopy];
        }else{
            titleToID = [[NSMutableDictionary alloc] init];
            idToChapter = [[NSMutableDictionary alloc] init];
            [userDefaults setObject:titleToID forKey: extractTitleToID];
            [userDefaults setObject:idToChapter forKey:extractIDtoChapter];
        }
        //initialize and store library data
        NSData *jsonLib = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.mangaeden.com/api/list/0/"]];
        NSError *error;
        NSDictionary *library = [NSJSONSerialization JSONObjectWithData:jsonLib options:0 error:&error];
        libArray = [library objectForKey:@"manga"];
    }
    return self;
}

//add a manga title to database
- (BOOL) addMangaWithTitle:(NSString*)title andAlias: (NSString*)alias {
    NSString *mangaID;
    
    for (NSDictionary* entry in libArray){
        if ([[entry objectForKey:@"a"] isEqualTo:alias]){
            mangaID = [entry objectForKey:@"i"];
        }
    }
    if (!mangaID){return NO;}
    
    [titleToID setObject:mangaID forKey:title];
    [idToChapter setObject:@"-1" forKey:mangaID];
    [self synchronize];
    
    return YES;
}

//remove a manga title from database
- (void) removeMangaWithTitle:(NSString*)title {
//    NSLog(@"removeObjectForKey called");
    [idToChapter removeObjectForKey:[titleToID objectForKey:title]];
    [titleToID removeObjectForKey:title];
    [self synchronize];
}

//central method to synchronize user settings 
- (void) synchronize{
    [userDefaults setObject:[titleToID copy] forKey:extractTitleToID];
    [userDefaults setObject:[idToChapter copy] forKey:extractIDtoChapter];
    [userDefaults synchronize];

}

//return an array of all manga titles
- (NSArray*) listOfManga {
    return [titleToID allKeys];
}


//method for AppDelegate to refresh chapter database
- (void) backGroundRefresh: (NSTimer*)theTimer{
    [self fetchUpdates];
}



//update all chapters
- (void)fetchUpdates
{
    NSArray* allIDs = [idToChapter allKeys];
    for (NSString* mangaID in allIDs){
        NSData *mangaEntry = [NSData dataWithContentsOfURL:
                              [NSURL URLWithString:
                               [NSString stringWithFormat:@"http://www.mangaeden.com/api/manga/%@",mangaID]]];
        NSError *error;
        NSDictionary* mangaDict = [NSJSONSerialization JSONObjectWithData:mangaEntry options:0 error:&error];
        
        NSString *lastChapterDate = [mangaDict objectForKey:@"last_chapter_date"];
        NSString *myChapterDate = [idToChapter objectForKey:mangaID];
        NSLog(@"%@", lastChapterDate);
        NSLog(@"%@", myChapterDate);
        
        if ([lastChapterDate doubleValue] > [myChapterDate doubleValue]){
            [idToChapter setObject:lastChapterDate forKey:mangaID];

            [self alertLastestChapter:[[[mangaDict objectForKey:@"chapters"] objectAtIndex:0] objectAtIndex:2]
                            OfMangaID:mangaID
                             andTitle:[mangaDict objectForKey:@"title"]
                            withAlias:[mangaDict objectForKey:@"alias"]];
        }
    }
    [self synchronize];
}

//always reprent notificaiton
- (BOOL)userNotificationCenter:(NSUserNotificationCenter*)center shouldPresentNotification:(NSUserNotification*)notification{
    return YES;
}

//open up the manga's link when click action button
- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification{
    if (notification.activationType == NSUserNotificationActivationTypeActionButtonClicked){
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mangaeden.com/en-manga/%@/%@/",
                                           [notification.userInfo objectForKey:@"alias"],
                                           [notification.userInfo objectForKey:@"chapterNum"]]];
        
        [[NSWorkspace sharedWorkspace] openURL:url];

    }
}

//method to alert through NSNotificationCenter
- (void) alertLastestChapter:(NSString*)chapterNum OfMangaID:(NSString*)ID andTitle:(NSString*)title withAlias:(NSString*)alias
{
    NSUserNotification *alert = [[NSUserNotification alloc] init];
    alert.title = @"New Chapter Released!";
    alert.subtitle = [NSString stringWithFormat:@"%@", title];
    alert.informativeText = [NSString stringWithFormat:@"Chapter %@ is out", chapterNum];
    alert.soundName = [NSSound soundNamed:@"susumi.aif"];
    alert.hasActionButton = YES;
    alert.actionButtonTitle = @"Read Now";
    alert.otherButtonTitle = @"Later";
    NSMutableDictionary *attached = [[NSMutableDictionary alloc]init];
    [attached setObject:chapterNum forKey:@"chapterNum"];
    [attached setObject:alias forKey:@"alias"];
    alert.userInfo = attached;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:alert];
}



@end

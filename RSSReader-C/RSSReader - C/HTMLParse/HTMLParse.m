//
//  HTMLParse.m
//  RSSReader - C
//
//  Created by Slava on 8/2/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "HTMLParse.h"
#import "CoreDataManager.h"
#import "Element+CoreDataClass.h"
#import "Content+CoreDataClass.h"


static NSString* const urlName = @"https://news.tut.by/rss.html";

@interface HTMLParse()

@property (strong, nonatomic) NSManagedObjectContext* context;

-(NSArray*) setDataIntoDictionary: (NSString*) stringHTML;

@end


@implementation HTMLParse

- (NSManagedObjectContext*)context {
    if (!_context) {
        _context = [CoreDataManager shared].persistentContainer.viewContext;
    }
    return _context;
}

- (void) getArrayDataForUI:(void(^)(NSArray* result))complition {
    
    NSURLSessionConfiguration* defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* sesion = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSURL* url = [NSURL URLWithString:urlName];
    
    [[sesion downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData* data= [NSData dataWithContentsOfURL:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data != nil) {
                NSString* stringHTML = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSArray* array =  [self setDataIntoDictionary:stringHTML];
                complition(array);
            }
        });
    }] resume];
}

- (NSArray*) setDataIntoDictionary: (NSString*) stringHTML {
    
    NSMutableArray* arrayContent = [NSMutableArray array];
    
    NSString* nameClassStart = @"lists__li lists__li_head";
    NSString* nameClassEnd = @"main-shd";
                                                                                // get necessary data for work
    NSString* copyStringHTML = [NSString stringWithString:stringHTML];
    NSRange startRange = [copyStringHTML rangeOfString:nameClassStart];
    NSRange endRange = [copyStringHTML rangeOfString:nameClassEnd];
    NSInteger lenght = (endRange.location - startRange.location);
    NSInteger location = (startRange.location + startRange.length );
    
    NSString* workingText = [copyStringHTML substringWithRange:NSMakeRange(location, lenght)];
    
    NSArray* resultForMainTitles = [workingText componentsSeparatedByString:nameClassStart];
    
    int tagForContent = 0;
    for (NSString* str in resultForMainTitles) {                               // get data for section in UITableView
        
        NSArray* tempForTitle = [str componentsSeparatedByString:@"<a href="];
        NSString* contentForMainTitle = tempForTitle[0];
        NSArray* newTempArray = [contentForMainTitle componentsSeparatedByString:@"<"];
        NSString* newTempTitle = newTempArray[0];
        
        NSString* title = [newTempTitle substringWithRange:NSMakeRange(2, [newTempTitle length] - 2)];
        
        Content* content = [NSEntityDescription insertNewObjectForEntityForName:@"Content" inManagedObjectContext:self.context];
        content.mainTitle = title;
        content.tag = tagForContent;
        tagForContent++;
        
        NSMutableArray* arrayForTitleAndUrl = [NSMutableArray arrayWithArray:tempForTitle];
        [arrayForTitleAndUrl removeObjectAtIndex:0];
        
        int tagForElement = 0;
        
        for (NSString* str in arrayForTitleAndUrl) {                             // get data for row in UITAbleView
            
            NSArray* tempTitleAndUrl = [str componentsSeparatedByString:@"<"];
            NSString* tempString = tempTitleAndUrl[0];
            NSArray* newTempArray = [tempString componentsSeparatedByString:@">"];
            NSString* tempUrl = (NSString*)newTempArray[0];
            NSString* title = newTempArray[1];
            NSString* url = [tempUrl substringWithRange:NSMakeRange(1, [tempUrl length] - 2)];
            
            Element* element = [NSEntityDescription insertNewObjectForEntityForName:@"Element" inManagedObjectContext:self.context];
            element.title = title;
            element.url = url;
            element.tag = tagForElement;
            tagForElement++;
            
            [content addElementObject:element];
            
        }
        [arrayContent addObject:content];
        [self.context save:nil];
    }
    return  arrayContent;
}

@end
